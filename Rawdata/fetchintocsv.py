from snowflake.snowpark.context import get_active_session
from datetime import datetime, date
import csv
import os
import tempfile

session = get_active_session()

DB_NAME    = "DCF_TEST"
STAGE_NAME = "POSTGRES_STAGE"
SCHEMA     = "PUBLIC"
LIMIT_ROWS = 100
TMP_DIR    = tempfile.gettempdir()

EXPORT_CONFIG = {
    "PUBLIC": []
}

# create stage
session.sql(f"""
    CREATE STAGE IF NOT EXISTS {DB_NAME}.{SCHEMA}.{STAGE_NAME}
""").collect()

stage_location = "@DCF_RAWDATA.RAWDATA.POSTGRES_STAGE"

for schema_name, table_list in EXPORT_CONFIG.items():
    print(f"\nProcessing Schema: {schema_name}")

    try:
        if not table_list:
            rows = session.sql(f"""
                SELECT TABLE_NAME
                FROM {DB_NAME}.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_SCHEMA = '{schema_name}'
                  AND TABLE_TYPE   = 'BASE TABLE'
                ORDER BY TABLE_NAME
            """).collect()
            table_list = [r["TABLE_NAME"] for r in rows]

        if not table_list:
            print(f"  No tables found in schema {schema_name}")
            continue

        for table_name in table_list:
            full_table_name = f"{DB_NAME}.{schema_name}.{table_name}"
            print(f"  Exporting: {full_table_name}")

            try:
                df   = session.table(full_table_name).limit(LIMIT_ROWS)
                rows = df.collect()

                if not rows:
                    print(f"  No data found in {full_table_name}, skipping")
                    continue

                columns = df.columns

                local_folder = os.path.join(TMP_DIR, table_name)
                os.makedirs(local_folder, exist_ok=True)

                file_name = f"{table_name}.csv"
                file_path = os.path.join(local_folder, file_name)

                with open(file_path, "w", encoding="utf-8", newline="") as f:
                    writer = csv.writer(f, quoting=csv.QUOTE_ALL)
                    writer.writerow(columns)
                    for row in rows:
                        formatted = []
                        for v in row:
                            if v is None:
                                formatted.append("")
                            elif isinstance(v, datetime):
                                formatted.append(v.strftime("%Y-%m-%d %H:%M:%S"))
                            elif isinstance(v, date):
                                formatted.append(v.strftime("%Y-%m-%d"))
                            else:
                                formatted.append(str(v))
                        writer.writerow(formatted)

                table_stage = f"{stage_location}/{table_name}"
                session.file.put(
                    file_path,
                    table_stage,
                    overwrite=True,
                    auto_compress=False
                )
                print(f"  Uploaded: {table_name}/{file_name}")

            except Exception as table_error:
                print(f"  Error processing {full_table_name}: {table_error}")

    except Exception as schema_error:
        print(f"  Error processing schema {schema_name}: {schema_error}")

print("\nAll tables exported.")
session.sql(f"LIST {stage_location}").show()
