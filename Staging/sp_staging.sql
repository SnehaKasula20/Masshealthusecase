-- Staging layer Snowpark Python stored procedures
-- Co-authored with CoCo

USE DATABASE DCF_RAWDATA;
USE SCHEMA STAGING;

-- ALLOWABLE_VALUES
CREATE OR REPLACE PROCEDURE DCF_RAWDATA.STAGING.SP_STG_ALLOWABLE_VALUES()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS
$$
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp

def run(session):
    job_id = str(uuid.uuid4())
    job_name = 'STG_ALLOWABLE_VALUES_LOAD'
    start_time = datetime.now()

    try:
        stream_df = session.table("DCF_RAWDATA.PUBLIC.STREAM_T_ALLOWABLE_VALUES").filter(
            col("METADATA$ACTION") == "INSERT"
        ).drop("METADATA$ACTION", "METADATA$ISUPDATE", "METADATA$ROW_ID").cache_result()

        ind_cols = ["VALUE_DEFAULT_IND"]
        code_cols = ["VALUE_CODE"]
        desc_cols = ["VALUE_SHORT_DESC", "VALUE_LONG_DESC"]
        user_cols = ["ADD_USER", "MOD_USER"]
        trim_cols = ["MINIMUM_NUM", "MAXIMUM_NUM", "SOURCE_FILE_NAME"]

        all_cols = [c.name for c in stream_df.schema.fields]
        select_exprs = []
        for c in all_cols:
            if c == "LOAD_TIMESTAMP":
                select_exprs.append(col(c).alias("RAW_LOAD_TIMESTAMP"))
            elif c in ind_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("N")).otherwise(trim(col(c))), lit("N")).alias(c))
            elif c in code_cols:
                select_exprs.append(upper(trim(col(c))).alias(c))
            elif c in desc_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("NA")).otherwise(trim(col(c))), lit("NA")).alias(c))
            elif c in user_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("SYSTEM")).otherwise(trim(col(c))), lit("SYSTEM")).alias(c))
            elif c in trim_cols:
                select_exprs.append(trim(col(c)).alias(c))
            else:
                select_exprs.append(col(c))

        clean_df = stream_df.select(select_exprs)
        valid_df = clean_df.filter(col("AV_ID").is_not_null())
        invalid_df = clean_df.filter(col("AV_ID").is_null())

        final_df = valid_df.with_column("STAGING_LOADED_TIMESTAMP", current_timestamp())
        final_df.write.save_as_table("DCF_RAWDATA.STAGING.STG_ALLOWABLE_VALUES", mode="truncate")

        rows_processed = final_df.count()
        rows_failed = invalid_df.count()

        if rows_failed > 0:
            invalid_df.select(
                lit("T_ALLOWABLE_VALUES").alias("TABLE_NAME"),
                lit("AV_ID_NULL").alias("ERROR_REASON"),
                col("SOURCE_FILE_NAME"),
                col("RAW_LOAD_TIMESTAMP")
            ).write.save_as_table("DCF_RAWDATA.STAGING.INVALID_RECORDS", mode="append")

        status = 'SUCCESS' if rows_failed == 0 else 'PARTIAL_SUCCESS'
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, 'STAGING', f'ALLOWABLE_VALUES staging completed. Rows: {rows_processed}, Failed: {rows_failed}')

        return f'SUCCESS: {rows_processed} rows loaded'

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), 0, 1, 'FAILED', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", 'FAILED', job_name, 'STAGING', f'ALLOWABLE_VALUES staging failed. Error: {str(e)}')
        return f'FAILED: {str(e)}'
$$;

-- PERSONS
CREATE OR REPLACE PROCEDURE DCF_RAWDATA.STAGING.SP_STG_PERSONS()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS
$$
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = 'STG_PERSONS_LOAD'
    start_time = datetime.now()

    try:
        stream_df = session.table("DCF_RAWDATA.PUBLIC.STREAM_T_PERSONS").filter(
            col("METADATA$ACTION") == "INSERT"
        ).drop("METADATA$ACTION", "METADATA$ISUPDATE", "METADATA$ROW_ID").cache_result()

        ind_cols = ["DO_NOT_RESUSCITATE_IND", "EDUCATIONAL_PARENT_IND", "GUARDIANSHIP_CONSENT_IND",
                    "ADOPTION_NOT_APPROPRIATE_IND", "BIO_PARENTS_RETURN_IND", "BIRTH_CERTIFICATE_AVLBL_IND",
                    "NO_PHONE_IND", "PET_OWNER_IND", "SMOKER_IND", "SSN_VALIDATION_IND",
                    "RESTRICTED_IND", "ADOPTION_MATCH_FOUND_IND", "APPROXIMATE_DOB_IND", "APPROX_LAST_ADOPTED_DATE_IND"]
        code_cols = ["CITIZENSHIP_CODE", "PRIMARY_LANGUAGE_CODE", "MARITAL_STATUS_CODE", "PREFIX_CODE",
                     "SUFFIX_CODE", "PROFESSIONAL_SUFFIX_CODE", "AGE_UNIT_CODE", "BIRTH_PLACE_STATE_CODE",
                     "BIRTH_PLACE_COUNTRY_CODE", "DECEASED_COUNTRY_CODE", "DECEASED_STATE_CODE",
                     "CURRENT_GRADE_CODE", "ETHNICITY_CODE", "GENDER_CODE", "IMMIGRATION_STATUS_CODE",
                     "RACE_CODE", "RELIGION_CODE", "SSN_SOURCE_CODE", "CHILD_ADOPTED_CODE",
                     "AGE_CHILD_ADP_UNIT_CODE", "DUP_PERSON_STATUS_CODE"]
        desc_cols = ["FIRST_NAME", "LAST_NAME", "MIDDLE_NAME", "OCCUPATION_DESC"]
        user_cols = ["ADD_USER", "MOD_USER"]
        trim_cols = ["BIRTH_PLACE_CITY_NAME", "BIRTH_PLACE_HOSPITAL_NAME", "DECEASED_CITY_NAME",
                     "ALIEN_REGISTRATION_NUM", "SOCIAL_SECURITY_NUM", "ITIN_NUM", "ARCHIVE_FILE_NAME", "SOURCE_FILE_NAME"]

        all_cols = [c.name for c in stream_df.schema.fields]
        select_exprs = []
        for c in all_cols:
            if c == "LOAD_TIMESTAMP":
                select_exprs.append(col(c).alias("RAW_LOAD_TIMESTAMP"))
            elif c in ind_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("N")).otherwise(trim(col(c))), lit("N")).alias(c))
            elif c in code_cols:
                select_exprs.append(upper(trim(col(c))).alias(c))
            elif c in desc_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("NA")).otherwise(trim(col(c))), lit("NA")).alias(c))
            elif c in user_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("SYSTEM")).otherwise(trim(col(c))), lit("SYSTEM")).alias(c))
            elif c in trim_cols:
                select_exprs.append(trim(col(c)).alias(c))
            else:
                select_exprs.append(col(c))

        clean_df = stream_df.select(select_exprs)

        valid_df = clean_df.filter(col("PERSON_ID").is_not_null())
        invalid_df = clean_df.filter(col("PERSON_ID").is_null())

        checksum_exprs = [coalesce(col("PERSON_ID").cast("string"), lit("")),
                          coalesce(col("LAST_NAME"), lit("")), coalesce(col("FIRST_NAME"), lit("")),
                          coalesce(col("GENDER_CODE"), lit("")), coalesce(col("BIRTH_DATE").cast("string"), lit("")),
                          coalesce(col("ADD_USER"), lit("")), coalesce(col("MOD_USER"), lit("")),
                          coalesce(col("DELETED_DATE").cast("string"), lit(""))]

        final_df = valid_df.with_column("CHECKSUM", sha2(concat_ws(lit("|"), *checksum_exprs), 256)
        ).with_column("STAGING_LOADED_TIMESTAMP", current_timestamp())

        final_df.write.save_as_table("DCF_RAWDATA.STAGING.STG_PERSONS", mode="truncate")

        rows_processed = final_df.count()
        rows_failed = invalid_df.count()

        if rows_failed > 0:
            invalid_df.select(
                lit("T_PERSONS").alias("TABLE_NAME"), lit("PERSON_ID_NULL").alias("ERROR_REASON"),
                col("SOURCE_FILE_NAME"), col("RAW_LOAD_TIMESTAMP")
            ).write.save_as_table("DCF_RAWDATA.STAGING.INVALID_RECORDS", mode="append")

        status = 'SUCCESS' if rows_failed == 0 else 'PARTIAL_SUCCESS'
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, 'STAGING', f'PERSONS staging completed. Rows: {rows_processed}, Failed: {rows_failed}')

        return f'SUCCESS: {rows_processed} rows loaded'

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), 0, 1, 'FAILED', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", 'FAILED', job_name, 'STAGING', f'PERSONS staging failed. Error: {str(e)}')
        return f'FAILED: {str(e)}'
$$;

-- CASES
CREATE OR REPLACE PROCEDURE DCF_RAWDATA.STAGING.SP_STG_CASES()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS
$$
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = 'STG_CASES_LOAD'
    start_time = datetime.now()

    try:
        stream_df = session.table("DCF_RAWDATA.PUBLIC.STREAM_T_CASES").filter(
            col("METADATA$ACTION") == "INSERT"
        ).drop("METADATA$ACTION", "METADATA$ISUPDATE", "METADATA$ROW_ID").cache_result()

        ind_cols = ["RESTRICTED_IND", "CASE_ACCESS_IND"]
        code_cols = ["CASE_TYPE", "CURRENT_CASE_STATUS_CODE", "RESTRICTION_REASON_CODE"]
        desc_cols = ["CASE_NAME", "CASE_CMNT", "IMPORTANT_OBSERVATIONS", "RESTRICTION_REASON_CMNT"]
        user_cols = ["ADD_USER", "MOD_USER"]
        trim_cols = ["UC_CASE_NAME", "ASSIST_CASE_NUM", "ARCHIVE_FILE_NAME", "SOURCE_FILE_NAME"]

        all_cols = [c.name for c in stream_df.schema.fields]
        select_exprs = []
        for c in all_cols:
            if c == "LOAD_TIMESTAMP":
                select_exprs.append(col(c).alias("RAW_LOAD_TIMESTAMP"))
            elif c in ind_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("N")).otherwise(trim(col(c))), lit("N")).alias(c))
            elif c in code_cols:
                select_exprs.append(upper(trim(col(c))).alias(c))
            elif c in desc_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("NA")).otherwise(trim(col(c))), lit("NA")).alias(c))
            elif c in user_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("SYSTEM")).otherwise(trim(col(c))), lit("SYSTEM")).alias(c))
            elif c in trim_cols:
                select_exprs.append(trim(col(c)).alias(c))
            else:
                select_exprs.append(col(c))

        clean_df = stream_df.select(select_exprs)
        valid_df = clean_df.filter(col("CAS_ID").is_not_null())
        invalid_df = clean_df.filter(col("CAS_ID").is_null())

        checksum_exprs = [coalesce(col("CAS_ID").cast("string"), lit("")), coalesce(col("CASE_TYPE"), lit("")),
                          coalesce(col("CASE_NAME"), lit("")), coalesce(col("RESTRICTED_IND"), lit("")),
                          coalesce(col("CURRENT_CASE_STATUS_CODE"), lit("")), coalesce(col("ADD_USER"), lit("")),
                          coalesce(col("MOD_USER"), lit("")), coalesce(col("DELETED_DATE").cast("string"), lit(""))]

        final_df = valid_df.with_column("CHECKSUM", sha2(concat_ws(lit("|"), *checksum_exprs), 256)
        ).with_column("STAGING_LOADED_TIMESTAMP", current_timestamp())

        final_df.write.save_as_table("DCF_RAWDATA.STAGING.STG_CASES", mode="truncate")

        rows_processed = final_df.count()
        rows_failed = invalid_df.count()

        if rows_failed > 0:
            invalid_df.select(
                lit("T_CASES").alias("TABLE_NAME"), lit("CAS_ID_NULL").alias("ERROR_REASON"),
                col("SOURCE_FILE_NAME"), col("RAW_LOAD_TIMESTAMP")
            ).write.save_as_table("DCF_RAWDATA.STAGING.INVALID_RECORDS", mode="append")

        status = 'SUCCESS' if rows_failed == 0 else 'PARTIAL_SUCCESS'
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, 'STAGING', f'CASES staging completed. Rows: {rows_processed}, Failed: {rows_failed}')

        return f'SUCCESS: {rows_processed} rows loaded'

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), 0, 1, 'FAILED', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", 'FAILED', job_name, 'STAGING', f'CASES staging failed. Error: {str(e)}')
        return f'FAILED: {str(e)}'
$$;

-- MEDICATIONS
CREATE OR REPLACE PROCEDURE DCF_RAWDATA.STAGING.SP_STG_MEDICATIONS()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS
$$
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = 'STG_MEDICATIONS_LOAD'
    start_time = datetime.now()

    try:
        stream_df = session.table("DCF_RAWDATA.PUBLIC.STREAM_T_MEDICATIONS").filter(
            col("METADATA$ACTION") == "INSERT"
        ).drop("METADATA$ACTION", "METADATA$ISUPDATE", "METADATA$ROW_ID").cache_result()

        ind_cols = ["ROGER_DECISION_DRUG_IND"]
        code_cols = ["MEDICATION_CLASSIFICATION_CODE"]
        desc_cols = ["COMMON_NAME", "MEDICATION_DESC"]
        user_cols = ["ADD_USER", "MOD_USER"]
        trim_cols = ["SOURCE_FILE_NAME"]

        all_cols = [c.name for c in stream_df.schema.fields]
        select_exprs = []
        for c in all_cols:
            if c == "LOAD_TIMESTAMP":
                select_exprs.append(col(c).alias("RAW_LOAD_TIMESTAMP"))
            elif c in ind_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("N")).otherwise(trim(col(c))), lit("N")).alias(c))
            elif c in code_cols:
                select_exprs.append(upper(trim(col(c))).alias(c))
            elif c in desc_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("NA")).otherwise(trim(col(c))), lit("NA")).alias(c))
            elif c in user_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("SYSTEM")).otherwise(trim(col(c))), lit("SYSTEM")).alias(c))
            elif c in trim_cols:
                select_exprs.append(trim(col(c)).alias(c))
            else:
                select_exprs.append(col(c))

        clean_df = stream_df.select(select_exprs)
        valid_df = clean_df.filter(col("MED_ID").is_not_null())
        invalid_df = clean_df.filter(col("MED_ID").is_null())

        checksum_exprs = [coalesce(col("MED_ID").cast("string"), lit("")), coalesce(col("COMMON_NAME"), lit("")),
                          coalesce(col("MEDICATION_DESC"), lit("")), coalesce(col("ROGER_DECISION_DRUG_IND"), lit("")),
                          coalesce(col("MEDICATION_CLASSIFICATION_CODE"), lit("")),
                          coalesce(col("ADD_USER"), lit("")), coalesce(col("MOD_USER"), lit(""))]

        final_df = valid_df.with_column("CHECKSUM", sha2(concat_ws(lit("|"), *checksum_exprs), 256)
        ).with_column("STAGING_LOADED_TIMESTAMP", current_timestamp())

        final_df.write.save_as_table("DCF_RAWDATA.STAGING.STG_MEDICATIONS", mode="truncate")

        rows_processed = final_df.count()
        rows_failed = invalid_df.count()

        if rows_failed > 0:
            invalid_df.select(
                lit("T_MEDICATIONS").alias("TABLE_NAME"), lit("MED_ID_NULL").alias("ERROR_REASON"),
                col("SOURCE_FILE_NAME"), col("RAW_LOAD_TIMESTAMP")
            ).write.save_as_table("DCF_RAWDATA.STAGING.INVALID_RECORDS", mode="append")

        status = 'SUCCESS' if rows_failed == 0 else 'PARTIAL_SUCCESS'
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, 'STAGING', f'MEDICATIONS staging completed. Rows: {rows_processed}, Failed: {rows_failed}')

        return f'SUCCESS: {rows_processed} rows loaded'

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), 0, 1, 'FAILED', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", 'FAILED', job_name, 'STAGING', f'MEDICATIONS staging failed. Error: {str(e)}')
        return f'FAILED: {str(e)}'
$$;

-- CUSTODIES
CREATE OR REPLACE PROCEDURE DCF_RAWDATA.STAGING.SP_STG_CUSTODIES()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS
$$
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = 'STG_CUSTODIES_LOAD'
    start_time = datetime.now()

    try:
        stream_df = session.table("DCF_RAWDATA.PUBLIC.STREAM_T_CUSTODIES").filter(
            col("METADATA$ACTION") == "INSERT"
        ).drop("METADATA$ACTION", "METADATA$ISUPDATE", "METADATA$ROW_ID").cache_result()

        ind_cols = ["TWENTY_NINE_C_IND"]
        code_cols = ["LEGAL_STATUS_CODE", "END_REASON_CODE", "CUSTODY_TYPE"]
        user_cols = ["ADD_USER", "MOD_USER"]
        trim_cols = ["SOURCE_FILE_NAME"]

        all_cols = [c.name for c in stream_df.schema.fields]
        select_exprs = []
        for c in all_cols:
            if c == "LOAD_TIMESTAMP":
                select_exprs.append(col(c).alias("RAW_LOAD_TIMESTAMP"))
            elif c in ind_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("N")).otherwise(trim(col(c))), lit("N")).alias(c))
            elif c in code_cols:
                select_exprs.append(upper(trim(col(c))).alias(c))
            elif c in user_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("SYSTEM")).otherwise(trim(col(c))), lit("SYSTEM")).alias(c))
            elif c in trim_cols:
                select_exprs.append(trim(col(c)).alias(c))
            else:
                select_exprs.append(col(c))

        clean_df = stream_df.select(select_exprs)
        valid_df = clean_df.filter(col("CUS_ID").is_not_null())
        invalid_df = clean_df.filter(col("CUS_ID").is_null())

        checksum_exprs = [coalesce(col("CUS_ID").cast("string"), lit("")), coalesce(col("LEGAL_STATUS_CODE"), lit("")),
                          coalesce(col("TWENTY_NINE_C_IND"), lit("")), coalesce(col("CUSTODY_TYPE"), lit("")),
                          coalesce(col("END_REASON_CODE"), lit("")), coalesce(col("ADD_USER"), lit("")),
                          coalesce(col("MOD_USER"), lit("")), coalesce(col("PERSON_PERSON_ID").cast("string"), lit("")),
                          coalesce(col("START_DATE").cast("string"), lit("")), coalesce(col("END_DATE").cast("string"), lit(""))]

        final_df = valid_df.with_column("CHECKSUM", sha2(concat_ws(lit("|"), *checksum_exprs), 256)
        ).with_column("STAGING_LOADED_TIMESTAMP", current_timestamp())

        final_df.write.save_as_table("DCF_RAWDATA.STAGING.STG_CUSTODIES", mode="truncate")

        rows_processed = final_df.count()
        rows_failed = invalid_df.count()

        if rows_failed > 0:
            invalid_df.select(
                lit("T_CUSTODIES").alias("TABLE_NAME"), lit("CUS_ID_NULL").alias("ERROR_REASON"),
                col("SOURCE_FILE_NAME"), col("RAW_LOAD_TIMESTAMP")
            ).write.save_as_table("DCF_RAWDATA.STAGING.INVALID_RECORDS", mode="append")

        status = 'SUCCESS' if rows_failed == 0 else 'PARTIAL_SUCCESS'
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, 'STAGING', f'CUSTODIES staging completed. Rows: {rows_processed}, Failed: {rows_failed}')

        return f'SUCCESS: {rows_processed} rows loaded'

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), 0, 1, 'FAILED', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", 'FAILED', job_name, 'STAGING', f'CUSTODIES staging failed. Error: {str(e)}')
        return f'FAILED: {str(e)}'
$$;

-- PERSON_ORG_INVOLVEMENT
CREATE OR REPLACE PROCEDURE DCF_RAWDATA.STAGING.SP_STG_PERSON_ORG_INVOLVEMENT()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS
$$
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = 'STG_PERSON_ORG_INVOLVEMENT_LOAD'
    start_time = datetime.now()

    try:
        stream_df = session.table("DCF_RAWDATA.PUBLIC.STREAM_T_PERSON_ORG_INVOLVEMENT").filter(
            col("METADATA$ACTION") == "INSERT"
        ).drop("METADATA$ACTION", "METADATA$ISUPDATE", "METADATA$ROW_ID").cache_result()

        ind_cols = ["SEARCHED_IND"]
        code_cols = ["REASON_CLOSED_CODE"]
        user_cols = ["ADD_USER", "MOD_USER"]
        trim_cols = ["SOURCE_FILE_NAME"]

        all_cols = [c.name for c in stream_df.schema.fields]
        select_exprs = []
        for c in all_cols:
            if c == "LOAD_TIMESTAMP":
                select_exprs.append(col(c).alias("RAW_LOAD_TIMESTAMP"))
            elif c in ind_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("N")).otherwise(trim(col(c))), lit("N")).alias(c))
            elif c in code_cols:
                select_exprs.append(upper(trim(col(c))).alias(c))
            elif c in user_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("SYSTEM")).otherwise(trim(col(c))), lit("SYSTEM")).alias(c))
            elif c in trim_cols:
                select_exprs.append(trim(col(c)).alias(c))
            else:
                select_exprs.append(col(c))

        clean_df = stream_df.select(select_exprs)
        valid_df = clean_df.filter(col("POI_ID").is_not_null())
        invalid_df = clean_df.filter(col("POI_ID").is_null())

        checksum_exprs = [coalesce(col("POI_ID").cast("string"), lit("")), coalesce(col("SEARCHED_IND"), lit("")),
                          coalesce(col("REASON_CLOSED_CODE"), lit("")), coalesce(col("ADD_USER"), lit("")),
                          coalesce(col("MOD_USER"), lit("")), coalesce(col("PERSON_PERSON_ID").cast("string"), lit("")),
                          coalesce(col("CAS_CAS_ID").cast("string"), lit("")),
                          coalesce(col("START_DATE").cast("string"), lit("")), coalesce(col("END_DATE").cast("string"), lit(""))]

        final_df = valid_df.with_column("CHECKSUM", sha2(concat_ws(lit("|"), *checksum_exprs), 256)
        ).with_column("STAGING_LOADED_TIMESTAMP", current_timestamp())

        final_df.write.save_as_table("DCF_RAWDATA.STAGING.STG_PERSON_ORG_INVOLVEMENT", mode="truncate")

        rows_processed = final_df.count()
        rows_failed = invalid_df.count()

        if rows_failed > 0:
            invalid_df.select(
                lit("T_PERSON_ORG_INVOLVEMENT").alias("TABLE_NAME"), lit("POI_ID_NULL").alias("ERROR_REASON"),
                col("SOURCE_FILE_NAME"), col("RAW_LOAD_TIMESTAMP")
            ).write.save_as_table("DCF_RAWDATA.STAGING.INVALID_RECORDS", mode="append")

        status = 'SUCCESS' if rows_failed == 0 else 'PARTIAL_SUCCESS'
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, 'STAGING', f'POI staging completed. Rows: {rows_processed}, Failed: {rows_failed}')

        return f'SUCCESS: {rows_processed} rows loaded'

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), 0, 1, 'FAILED', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", 'FAILED', job_name, 'STAGING', f'POI staging failed. Error: {str(e)}')
        return f'FAILED: {str(e)}'
$$;

-- PERSON_ROLE_ASSIGNMENTS
CREATE OR REPLACE PROCEDURE DCF_RAWDATA.STAGING.SP_STG_PERSON_ROLE_ASSIGNMENTS()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS
$$
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = 'STG_PERSON_ROLE_ASSIGNMENTS_LOAD'
    start_time = datetime.now()

    try:
        stream_df = session.table("DCF_RAWDATA.PUBLIC.STREAM_T_PERSON_ROLE_ASSIGNMENTS").filter(
            col("METADATA$ACTION") == "INSERT"
        ).cache_result()

        clean_df = stream_df.select(
            col("PRA1_ID"), col("POI_POI_ID"),
            upper(trim(col("ROLE_TYPE"))).alias("ROLE_TYPE"),
            col("ADD_TS"),
            coalesce(when(trim(col("ADD_USER")) == lit(""), lit("SYSTEM")).otherwise(trim(col("ADD_USER"))), lit("SYSTEM")).alias("ADD_USER"),
            col("START_DATE"), col("END_DATE"), col("TICKLER_ID"),
            coalesce(when(trim(col("MOD_USER")) == lit(""), lit("SYSTEM")).otherwise(trim(col("MOD_USER"))), lit("SYSTEM")).alias("MOD_USER"),
            col("MOD_TS"),
            coalesce(when(trim(col("ROLE_SUB_TYPE")) == lit(""), lit("NA")).otherwise(trim(col("ROLE_SUB_TYPE"))), lit("NA")).alias("ROLE_SUB_TYPE"),
            col("LOADED_DATE"), col("DELETED_DATE"),
            col("LOAD_TIMESTAMP").alias("RAW_LOAD_TIMESTAMP"),
            col("SOURCE_FILE_NAME")
        )

        valid_df = clean_df.filter(col("PRA1_ID").is_not_null())
        invalid_df = clean_df.filter(col("PRA1_ID").is_null())

        checksum_exprs = [coalesce(col("PRA1_ID").cast("string"), lit("")), coalesce(col("POI_POI_ID").cast("string"), lit("")),
                          coalesce(col("ROLE_TYPE"), lit("")), coalesce(col("ROLE_SUB_TYPE"), lit("")),
                          coalesce(col("ADD_USER"), lit("")), coalesce(col("MOD_USER"), lit("")),
                          coalesce(col("START_DATE").cast("string"), lit("")), coalesce(col("END_DATE").cast("string"), lit("")),
                          coalesce(col("TICKLER_ID").cast("string"), lit(""))]

        final_df = valid_df.with_column("CHECKSUM", sha2(concat_ws(lit("|"), *checksum_exprs), 256)
        ).with_column("STAGING_LOADED_TIMESTAMP", current_timestamp())

        final_df.write.save_as_table("DCF_RAWDATA.STAGING.STG_PERSON_ROLE_ASSIGNMENTS", mode="truncate")

        rows_processed = final_df.count()
        rows_failed = invalid_df.count()

        if rows_failed > 0:
            invalid_df.select(
                lit("T_PERSON_ROLE_ASSIGNMENTS").alias("TABLE_NAME"), lit("PRA1_ID_NULL").alias("ERROR_REASON"),
                col("SOURCE_FILE_NAME"), col("RAW_LOAD_TIMESTAMP")
            ).write.save_as_table("DCF_RAWDATA.STAGING.INVALID_RECORDS", mode="append")

        status = 'SUCCESS' if rows_failed == 0 else 'PARTIAL_SUCCESS'
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, 'STAGING', f'PRA staging completed. Rows: {rows_processed}, Failed: {rows_failed}')

        return f'SUCCESS: {rows_processed} rows loaded'

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), 0, 1, 'FAILED', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", 'FAILED', job_name, 'STAGING', f'PRA staging failed. Error: {str(e)}')
        return f'FAILED: {str(e)}'
$$;

-- MEDICATION_HEALTH_BEHAVIOR
CREATE OR REPLACE PROCEDURE DCF_RAWDATA.STAGING.SP_STG_MEDICATION_HEALTH_BEHAVIOR()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS
$$
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = 'STG_MEDICATION_HEALTH_BEHAVIOR_LOAD'
    start_time = datetime.now()

    try:
        stream_df = session.table("DCF_RAWDATA.PUBLIC.STREAM_T_MEDICATION_HEALTH_BEHAVIOR").filter(
            col("METADATA$ACTION") == "INSERT"
        ).drop("METADATA$ACTION", "METADATA$ISUPDATE", "METADATA$ROW_ID").cache_result()

        ind_cols = ["THRIVE_FAILURE_IND", "DATE_UNKNOWN"]
        code_cols = ["PRESCRIBED_FREQUENCY_CODE", "ADMINISTER_METHOD_CODE", "CONSENT_DECISION_CODE"]
        desc_cols = ["MEDICATION_CMNT", "DOSAGE_DESC", "CLN_RESP_ADVERSE_EFFECT_CMNT", "CONSENT_COMMENTS"]
        user_cols = ["ADD_USER", "MOD_USER"]
        trim_cols = ["SOURCE_FILE_NAME"]

        all_cols = [c.name for c in stream_df.schema.fields]
        select_exprs = []
        for c in all_cols:
            if c == "LOAD_TIMESTAMP":
                select_exprs.append(col(c).alias("RAW_LOAD_TIMESTAMP"))
            elif c in ind_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("N")).otherwise(trim(col(c))), lit("N")).alias(c))
            elif c in code_cols:
                select_exprs.append(upper(trim(col(c))).alias(c))
            elif c in desc_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("NA")).otherwise(trim(col(c))), lit("NA")).alias(c))
            elif c in user_cols:
                select_exprs.append(coalesce(when(trim(col(c)) == lit(""), lit("SYSTEM")).otherwise(trim(col(c))), lit("SYSTEM")).alias(c))
            elif c in trim_cols:
                select_exprs.append(trim(col(c)).alias(c))
            else:
                select_exprs.append(col(c))

        clean_df = stream_df.select(select_exprs)

        valid_df = clean_df.filter(
            col("MHP_ID").is_not_null() & col("MED_MED_ID").is_not_null() & col("PERSON_PERSON_PATIENT_ID").is_not_null()
        )
        invalid_df = clean_df.filter(
            col("MHP_ID").is_null() | col("MED_MED_ID").is_null() | col("PERSON_PERSON_PATIENT_ID").is_null()
        )

        checksum_exprs = [coalesce(col("MHP_ID").cast("string"), lit("")), coalesce(col("MED_MED_ID").cast("string"), lit("")),
                          coalesce(col("PERSON_PERSON_PATIENT_ID").cast("string"), lit("")),
                          coalesce(col("THRIVE_FAILURE_IND"), lit("")), coalesce(col("DATE_UNKNOWN"), lit("")),
                          coalesce(col("PRESCRIBED_FREQUENCY_CODE"), lit("")), coalesce(col("ADMINISTER_METHOD_CODE"), lit("")),
                          coalesce(col("CONSENT_DECISION_CODE"), lit("")), coalesce(col("ADD_USER"), lit("")),
                          coalesce(col("MOD_USER"), lit("")), coalesce(col("START_DATE").cast("string"), lit("")),
                          coalesce(col("END_DATE").cast("string"), lit(""))]

        final_df = valid_df.with_column("CHECKSUM", sha2(concat_ws(lit("|"), *checksum_exprs), 256)
        ).with_column("STAGING_LOADED_TIMESTAMP", current_timestamp())

        final_df.write.save_as_table("DCF_RAWDATA.STAGING.STG_MEDICATION_HEALTH_BEHAVIOR", mode="truncate")

        rows_processed = final_df.count()
        rows_failed = invalid_df.count()

        if rows_failed > 0:
            invalid_df.select(
                lit("T_MEDICATION_HEALTH_BEHAVIOR").alias("TABLE_NAME"),
                when(col("MHP_ID").is_null(), lit("MHP_ID_NULL"))
                    .when(col("MED_MED_ID").is_null(), lit("MED_MED_ID_NULL"))
                    .otherwise(lit("PERSON_PERSON_PATIENT_ID_NULL")).alias("ERROR_REASON"),
                col("SOURCE_FILE_NAME"), col("RAW_LOAD_TIMESTAMP")
            ).write.save_as_table("DCF_RAWDATA.STAGING.INVALID_RECORDS", mode="append")

        status = 'SUCCESS' if rows_failed == 0 else 'PARTIAL_SUCCESS'
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, 'STAGING', f'MHB staging completed. Rows: {rows_processed}, Failed: {rows_failed}')

        return f'SUCCESS: {rows_processed} rows loaded'

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, 'STAGING', start_time, datetime.now(), 0, 1, 'FAILED', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", 'FAILED', job_name, 'STAGING', f'MHB staging failed. Error: {str(e)}')
        return f'FAILED: {str(e)}'
$$;
