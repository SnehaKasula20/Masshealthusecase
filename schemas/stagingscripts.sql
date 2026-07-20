create or replace schema STAGING;

create or replace TABLE INVALID_RECORDS (
	TABLE_NAME VARCHAR(16777216),
	FILE_NAME VARCHAR(16777216),
	PRIMARY_KEY_VALUE VARCHAR(16777216),
	ERROR_REASON VARCHAR(16777216),
	ROW_DATA VARIANT,
	INVALID_RECORD_TIMESTAMP TIMESTAMP_NTZ(9) DEFAULT CURRENT_TIMESTAMP()
);
create or replace TABLE STG_ALLOWABLE_VALUES (
	AV_PK_ID NUMBER(10,0),
	AV_ID VARCHAR(10) NOT NULL,
	AVC_AVC_ID NUMBER(10,0),
	VALUE_CODE VARCHAR(10),
	VALUE_SHORT_DESC VARCHAR(80),
	VALUE_DEFAULT_IND VARCHAR(1),
	VALUE_RULE_NUM NUMBER(38,0),
	VALUE_SORT_ORDER_NUM NUMBER(38,0),
	ADD_TS TIMESTAMP_LTZ(9),
	ADD_USER VARCHAR(20),
	MOD_TS TIMESTAMP_TZ(9),
	MOD_USER VARCHAR(20),
	DISCONTINUED_DATE TIMESTAMP_NTZ(9),
	VALUE_LONG_DESC VARCHAR(240),
	MINIMUM_NUM VARCHAR(12),
	MAXIMUM_NUM VARCHAR(12),
	LOADED_DATE TIMESTAMP_LTZ(9),
	RAW_LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	STAGING_LOADED_TIMESTAMP TIMESTAMP_NTZ(9),
	primary key (AV_ID)
);
create or replace TABLE STG_CASES (
	CAS_ID NUMBER(10,0) NOT NULL,
	CASE_TYPE VARCHAR(10) NOT NULL,
	CASE_NAME VARCHAR(35) NOT NULL,
	RESTRICTED_IND VARCHAR(1) NOT NULL,
	CASE_ACCESS_IND VARCHAR(1) NOT NULL,
	UC_CASE_NAME VARCHAR(35) NOT NULL,
	ADD_TS TIMESTAMP_NTZ(9) NOT NULL,
	ADD_USER VARCHAR(20) NOT NULL,
	MOD_TS TIMESTAMP_NTZ(9),
	MOD_USER VARCHAR(20),
	ASSIST_CASE_NUM VARCHAR(18),
	EXPECTED_CLOSE_DATE TIMESTAMP_NTZ(9),
	CASE_CMNT VARCHAR(2000),
	LAST_ELECTRON_RETRIEVAL_DATE TIMESTAMP_NTZ(9),
	UNIT_ORGN_ID NUMBER(10,0),
	AREA_ORGN_ID NUMBER(10,0),
	REGION_ORGN_ID NUMBER(10,0),
	CURRENT_CASE_STATUS_CODE VARCHAR(10),
	CURRENT_CASE_STATUS_DATE TIMESTAMP_NTZ(9),
	ARCHIVE_DATE TIMESTAMP_NTZ(9),
	ARCHIVE_FILE_NAME VARCHAR(75),
	PERSON_PERSON_REQUESTS_ID NUMBER(10,0),
	RESTRICTION_REASON_CODE VARCHAR(10),
	RESTRICTION_REASON_CMNT VARCHAR(2000),
	RESTRICTION_DATE TIMESTAMP_NTZ(9),
	IMPORTANT_OBSERVATIONS VARCHAR(4000),
	LOADED_DATE TIMESTAMP_NTZ(9),
	CHECKSUM VARCHAR(99),
	DELETED_DATE TIMESTAMP_NTZ(9),
	RAW_LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	STAGING_LOADED_TIMESTAMP TIMESTAMP_NTZ(9),
	primary key (CAS_ID)
);
create or replace TABLE STG_CUSTODIES (
	CUS_ID NUMBER(10,0) NOT NULL,
	LEGAL_STATUS_CODE VARCHAR(10) NOT NULL,
	TWENTY_NINE_C_IND VARCHAR(1) NOT NULL,
	START_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ADD_TS TIMESTAMP_NTZ(9) NOT NULL,
	ADD_USER VARCHAR(20) NOT NULL,
	MOD_TS TIMESTAMP_NTZ(9),
	MOD_USER VARCHAR(20),
	PERSON_PERSON_ID NUMBER(10,0),
	ORGN_ORGN_ID NUMBER(10,0),
	VPA_VPA_ID NUMBER(10,0),
	SUR_SUR_ID NUMBER(10,0),
	CAP_CAP_ID NUMBER(10,0),
	POI_POI_ID NUMBER(10,0),
	CHILD_ADJUDICATED_DATE TIMESTAMP_NTZ(9),
	END_DATE TIMESTAMP_NTZ(9),
	TWENTY_NINE_C_DATE TIMESTAMP_NTZ(9),
	REASONABLE_EFFORT_DATE TIMESTAMP_NTZ(9),
	END_REASON_CODE VARCHAR(10),
	CUSTODY_TYPE VARCHAR(10),
	PERSON_PERSON_CHILD_ID NUMBER(10,0),
	TICKLER_ID NUMBER(10,0),
	MOD_CAP_CAP_ID NUMBER(10,0),
	LOADED_DATE TIMESTAMP_NTZ(9),
	CHECKSUM VARCHAR(99),
	DELETED_DATE TIMESTAMP_NTZ(9),
	RAW_LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	STAGING_LOADED_TIMESTAMP TIMESTAMP_NTZ(9),
	primary key (CUS_ID)
);
create or replace TABLE STG_MEDICATIONS (
	MED_ID NUMBER(10,0) NOT NULL,
	COMMON_NAME VARCHAR(80) NOT NULL,
	ROGER_DECISION_DRUG_IND VARCHAR(1) NOT NULL DEFAULT 'N',
	ADD_TS TIMESTAMP_NTZ(9) NOT NULL,
	ADD_USER VARCHAR(20) NOT NULL,
	MOD_TS TIMESTAMP_NTZ(9),
	MOD_USER VARCHAR(20),
	MEDICATION_DESC VARCHAR(80),
	ALLOW_FREQUENCY_NUM NUMBER(10,0),
	ADD_PERSON_ID NUMBER(10,0),
	ADD_ORGN_ID NUMBER(10,0),
	MOD_PERSON_ID NUMBER(10,0),
	MOD_ORGN_ID NUMBER(10,0),
	MEDICATION_CLASSIFICATION_CODE VARCHAR(10),
	LOADED_DATE TIMESTAMP_NTZ(9),
	CHECKSUM VARCHAR(99),
	DELETED_DATE TIMESTAMP_NTZ(9),
	RAW_LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	STAGING_LOADED_TIMESTAMP TIMESTAMP_NTZ(9),
	primary key (MED_ID)
);
create or replace TABLE STG_MEDICATION_HEALTH_BEHAVIOR (
	MHP_ID NUMBER(10,0) NOT NULL,
	MED_MED_ID NUMBER(10,0) NOT NULL,
	HPP_HPP_ID NUMBER(10,0),
	START_DATE TIMESTAMP_NTZ(9),
	ADD_TS TIMESTAMP_NTZ(9) NOT NULL,
	ADD_USER VARCHAR(20) NOT NULL,
	THRIVE_FAILURE_IND VARCHAR(1) NOT NULL DEFAULT 'N',
	PERSON_PERSON_PRESCRIBER_ID NUMBER(10,0),
	MEDICATION_CMNT VARCHAR(2000),
	MOD_TS TIMESTAMP_NTZ(9),
	MOD_USER VARCHAR(20),
	END_DATE TIMESTAMP_NTZ(9),
	PRESCRIBED_FREQUENCY_CODE VARCHAR(10),
	DOSAGE_DESC VARCHAR(80),
	ADMINISTER_METHOD_CODE VARCHAR(10),
	PERSON_PERSON_PATIENT_ID NUMBER(10,0) NOT NULL,
	DATE_UNKNOWN VARCHAR(1) NOT NULL DEFAULT 'N',
	PRESCRIBER_PCS_PCS_ID NUMBER(10,0),
	ADD_PERSON_ID NUMBER(10,0),
	ADD_ORGN_ID NUMBER(10,0),
	MOD_PERSON_ID NUMBER(10,0),
	MOD_ORGN_ID NUMBER(10,0),
	LAST_REFILL_DATE TIMESTAMP_NTZ(9),
	CLN_RESP_ADVERSE_EFFECT_CMNT VARCHAR(150),
	CONSENT_DATE TIMESTAMP_NTZ(9),
	CONSENT_DECISION_CODE VARCHAR(10),
	CONSENT_BY_PERSON_PERSON_ID NUMBER(10,0),
	CONSENT_COMMENTS VARCHAR(4000),
	LOADED_DATE TIMESTAMP_NTZ(9),
	CHECKSUM VARCHAR(99),
	DELETED_DATE TIMESTAMP_NTZ(9),
	RAW_LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	STAGING_LOADED_TIMESTAMP TIMESTAMP_NTZ(9),
	primary key (MHP_ID)
);
create or replace TABLE STG_PERSONS (
	PERSON_ID NUMBER(10,0) NOT NULL,
	LAST_NAME VARCHAR(25),
	CITIZENSHIP_CODE VARCHAR(10),
	PRIMARY_LANGUAGE_CODE VARCHAR(10),
	DO_NOT_RESUSCITATE_IND VARCHAR(1),
	EDUCATIONAL_PARENT_IND VARCHAR(1),
	GUARDIANSHIP_CONSENT_IND VARCHAR(1),
	ADOPTION_NOT_APPROPRIATE_IND VARCHAR(1),
	BIO_PARENTS_RETURN_IND VARCHAR(1),
	BIRTH_CERTIFICATE_AVLBL_IND VARCHAR(1),
	NO_PHONE_IND VARCHAR(1),
	PET_OWNER_IND VARCHAR(1),
	SMOKER_IND VARCHAR(1),
	SSN_VALIDATION_IND VARCHAR(1),
	RESTRICTED_IND VARCHAR(1),
	UC_LAST_NAME VARCHAR(25),
	SDX_LAST_NAME VARCHAR(25),
	ADD_TS TIMESTAMP_NTZ(9),
	ADD_USER VARCHAR(20),
	ADOPTION_MATCH_FOUND_IND VARCHAR(1),
	MOD_TS TIMESTAMP_NTZ(9),
	MOD_USER VARCHAR(20),
	MARITAL_STATUS_CODE VARCHAR(10),
	HEALTH_CERT_TICKLER_ID NUMBER(10,0),
	REEVALUATION_TICKLER_ID NUMBER(10,0),
	BIMONTHLY_VISIT_TICKLER_ID NUMBER(10,0),
	TICKLER_ID NUMBER(10,0),
	PREFIX_CODE VARCHAR(10),
	FIRST_NAME VARCHAR(15),
	MIDDLE_NAME VARCHAR(35),
	SUFFIX_CODE VARCHAR(10),
	PROFESSIONAL_SUFFIX_CODE VARCHAR(10),
	BIRTH_DATE DATE,
	SDX_FIRST_NAME VARCHAR(15),
	SDX_MIDDLE_NAME VARCHAR(15),
	UC_FIRST_NAME VARCHAR(15),
	UC_MIDDLE_NAME VARCHAR(15),
	AGE_NUM NUMBER(38,0),
	AGE_UNIT_CODE VARCHAR(10),
	BIRTH_PLACE_STATE_CODE VARCHAR(10),
	BIRTH_PLACE_CITY_NAME VARCHAR(35),
	BIRTH_PLACE_HOSPITAL_NAME VARCHAR(35),
	BIRTH_PLACE_COUNTRY_CODE VARCHAR(10),
	DECEASED_DATE TIMESTAMP_NTZ(9),
	DECEASED_COUNTRY_CODE VARCHAR(10),
	DECEASED_CITY_NAME VARCHAR(35),
	DECEASED_STATE_CODE VARCHAR(10),
	ALIEN_REGISTRATION_NUM VARCHAR(15),
	CURRENT_GRADE_CODE VARCHAR(10),
	ETHNICITY_CODE VARCHAR(10),
	GENDER_CODE VARCHAR(10),
	IMMIGRATION_STATUS_CODE VARCHAR(10),
	OCCUPATION_DESC VARCHAR(80),
	RACE_CODE VARCHAR(10),
	RELIGION_CODE VARCHAR(10),
	SOCIAL_SECURITY_NUM VARCHAR(9),
	SSN_SOURCE_CODE VARCHAR(10),
	SSN_REFUSAL_DATE TIMESTAMP_NTZ(9),
	BIRTH_DELIVERY_CMNT VARCHAR(2000),
	BIRTH_ORDER_SEQUENCE_NUM NUMBER(38,0),
	MARITAL_STATUS_EFFECT_DATE TIMESTAMP_NTZ(9),
	COMMON_CLIENT_ID NUMBER(10,0),
	CHILD_ADOPTED_CODE VARCHAR(10),
	AGE_CHILD_ADOPTED_NUM NUMBER(38,0),
	AGE_CHILD_ADP_UNIT_CODE VARCHAR(10),
	GESTATIONAL_AGE_NUM NUMBER(38,0),
	US_ENTRY_DATE TIMESTAMP_NTZ(9),
	ADOPTION_FREED_DATE TIMESTAMP_NTZ(9),
	ARCHIVE_DATE TIMESTAMP_NTZ(9),
	ARCHIVE_FILE_NAME VARCHAR(75),
	LAST_ELECTRON_RETRIEVAL_DATE TIMESTAMP_NTZ(9),
	PERSON_PERSON_REQUESTS_ID NUMBER(10,0),
	AFCARS_ADOPTION_SEND_DATE TIMESTAMP_NTZ(9),
	DUP_PERSON_STATUS_CODE VARCHAR(10),
	PERSON_PERSON_PRIMARY_ID NUMBER(10,0),
	LICENSE_RENEWAL_TICKLER_ID NUMBER(10,0),
	BI_ANNUAL_REASSESS_TICKLER_ID NUMBER(10,0),
	APPROXIMATE_DOB_IND VARCHAR(1),
	CHILD_ADOPTED_DATE TIMESTAMP_NTZ(9),
	APPROX_LAST_ADOPTED_DATE_IND VARCHAR(1),
	ITIN_NUM VARCHAR(9),
	LOADED_DATE TIMESTAMP_NTZ(9),
	CHECKSUM VARCHAR(99),
	DELETED_DATE TIMESTAMP_NTZ(9),
	RAW_LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	STAGING_LOADED_TIMESTAMP TIMESTAMP_NTZ(9),
	primary key (PERSON_ID)
);
create or replace TABLE STG_PERSON_ORG_INVOLVEMENT (
	POI_ID NUMBER(10,0) NOT NULL,
	START_DATE TIMESTAMP_NTZ(9) NOT NULL,
	SEARCHED_IND VARCHAR(1) NOT NULL,
	ADD_TS TIMESTAMP_NTZ(9) NOT NULL,
	ADD_USER VARCHAR(20) NOT NULL,
	INV_INV_ID NUMBER(10,0),
	ADR_ADR_CALLED_FROM_ID NUMBER(10,0),
	ORGN_ORGN_ID NUMBER(10,0),
	PERSON_PERSON_ID NUMBER(10,0),
	CAS_CAS_ID NUMBER(10,0),
	IC_IC_ID NUMBER(10,0),
	COMM_COMM_ID NUMBER(10,0),
	END_DATE TIMESTAMP_NTZ(9),
	REASON_CLOSED_CODE VARCHAR(10),
	MOD_TS TIMESTAMP_NTZ(9),
	MOD_USER VARCHAR(20),
	TICKLER_ID NUMBER(10,0),
	LOADED_DATE TIMESTAMP_NTZ(9),
	CHECKSUM VARCHAR(99),
	DELETED_DATE TIMESTAMP_NTZ(9),
	RAW_LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	STAGING_LOADED_TIMESTAMP TIMESTAMP_NTZ(9),
	primary key (POI_ID)
);
create or replace TABLE STG_PERSON_ROLE_ASSIGNMENTS (
	PRA1_ID NUMBER(10,0) NOT NULL,
	POI_POI_ID NUMBER(10,0) NOT NULL,
	ROLE_TYPE VARCHAR(10) NOT NULL,
	ADD_TS TIMESTAMP_NTZ(9) NOT NULL,
	ADD_USER VARCHAR(20) NOT NULL,
	START_DATE TIMESTAMP_NTZ(9) NOT NULL,
	END_DATE TIMESTAMP_NTZ(9),
	TICKLER_ID NUMBER(10,0),
	MOD_USER VARCHAR(20),
	MOD_TS TIMESTAMP_NTZ(9),
	ROLE_SUB_TYPE VARCHAR(10),
	LOADED_DATE TIMESTAMP_NTZ(9),
	CHECKSUM VARCHAR(99),
	DELETED_DATE TIMESTAMP_NTZ(9),
	RAW_LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	STAGING_LOADED_TIMESTAMP TIMESTAMP_NTZ(9),
	primary key (PRA1_ID)
);
CREATE OR REPLACE PROCEDURE "SP_STG_ALLOWABLE_VALUES"()
RETURNS VARCHAR
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
ARTIFACT_REPOSITORY = snowflake.snowpark.pypi_shared_repository
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS '
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp

def run(session):
    job_id = str(uuid.uuid4())
    job_name = ''STG_ALLOWABLE_VALUES_LOAD''
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

        status = ''SUCCESS'' if rows_failed == 0 else ''PARTIAL_SUCCESS''
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, ''STAGING'', f''ALLOWABLE_VALUES staging completed. Rows: {rows_processed}, Failed: {rows_failed}'')

        return f''SUCCESS: {rows_processed} rows loaded''

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), 0, 1, ''FAILED'', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", ''FAILED'', job_name, ''STAGING'', f''ALLOWABLE_VALUES staging failed. Error: {str(e)}'')
        return f''FAILED: {str(e)}''
';
CREATE OR REPLACE PROCEDURE "SP_STG_CASES"()
RETURNS VARCHAR
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
ARTIFACT_REPOSITORY = snowflake.snowpark.pypi_shared_repository
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS '
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = ''STG_CASES_LOAD''
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

        status = ''SUCCESS'' if rows_failed == 0 else ''PARTIAL_SUCCESS''
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, ''STAGING'', f''CASES staging completed. Rows: {rows_processed}, Failed: {rows_failed}'')

        return f''SUCCESS: {rows_processed} rows loaded''

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), 0, 1, ''FAILED'', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", ''FAILED'', job_name, ''STAGING'', f''CASES staging failed. Error: {str(e)}'')
        return f''FAILED: {str(e)}''
';
CREATE OR REPLACE PROCEDURE "SP_STG_CUSTODIES"()
RETURNS VARCHAR
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
ARTIFACT_REPOSITORY = snowflake.snowpark.pypi_shared_repository
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS '
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = ''STG_CUSTODIES_LOAD''
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

        status = ''SUCCESS'' if rows_failed == 0 else ''PARTIAL_SUCCESS''
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, ''STAGING'', f''CUSTODIES staging completed. Rows: {rows_processed}, Failed: {rows_failed}'')

        return f''SUCCESS: {rows_processed} rows loaded''

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), 0, 1, ''FAILED'', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", ''FAILED'', job_name, ''STAGING'', f''CUSTODIES staging failed. Error: {str(e)}'')
        return f''FAILED: {str(e)}''
';
CREATE OR REPLACE PROCEDURE "SP_STG_MEDICATIONS"()
RETURNS VARCHAR
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
ARTIFACT_REPOSITORY = snowflake.snowpark.pypi_shared_repository
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS '
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = ''STG_MEDICATIONS_LOAD''
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

        status = ''SUCCESS'' if rows_failed == 0 else ''PARTIAL_SUCCESS''
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, ''STAGING'', f''MEDICATIONS staging completed. Rows: {rows_processed}, Failed: {rows_failed}'')

        return f''SUCCESS: {rows_processed} rows loaded''

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), 0, 1, ''FAILED'', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", ''FAILED'', job_name, ''STAGING'', f''MEDICATIONS staging failed. Error: {str(e)}'')
        return f''FAILED: {str(e)}''
';
CREATE OR REPLACE PROCEDURE "SP_STG_MEDICATION_HEALTH_BEHAVIOR"()
RETURNS VARCHAR
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
ARTIFACT_REPOSITORY = snowflake.snowpark.pypi_shared_repository
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS '
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = ''STG_MEDICATION_HEALTH_BEHAVIOR_LOAD''
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

        status = ''SUCCESS'' if rows_failed == 0 else ''PARTIAL_SUCCESS''
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, ''STAGING'', f''MHB staging completed. Rows: {rows_processed}, Failed: {rows_failed}'')

        return f''SUCCESS: {rows_processed} rows loaded''

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), 0, 1, ''FAILED'', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", ''FAILED'', job_name, ''STAGING'', f''MHB staging failed. Error: {str(e)}'')
        return f''FAILED: {str(e)}''
';
CREATE OR REPLACE PROCEDURE "SP_STG_PERSONS"()
RETURNS VARCHAR
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
ARTIFACT_REPOSITORY = snowflake.snowpark.pypi_shared_repository
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS '
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = ''STG_PERSONS_LOAD''
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

        status = ''SUCCESS'' if rows_failed == 0 else ''PARTIAL_SUCCESS''
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, ''STAGING'', f''PERSONS staging completed. Rows: {rows_processed}, Failed: {rows_failed}'')

        return f''SUCCESS: {rows_processed} rows loaded''

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), 0, 1, ''FAILED'', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", ''FAILED'', job_name, ''STAGING'', f''PERSONS staging failed. Error: {str(e)}'')
        return f''FAILED: {str(e)}''
';
CREATE OR REPLACE PROCEDURE "SP_STG_PERSON_ORG_INVOLVEMENT"()
RETURNS VARCHAR
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
ARTIFACT_REPOSITORY = snowflake.snowpark.pypi_shared_repository
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS '
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = ''STG_PERSON_ORG_INVOLVEMENT_LOAD''
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

        status = ''SUCCESS'' if rows_failed == 0 else ''PARTIAL_SUCCESS''
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, ''STAGING'', f''POI staging completed. Rows: {rows_processed}, Failed: {rows_failed}'')

        return f''SUCCESS: {rows_processed} rows loaded''

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), 0, 1, ''FAILED'', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", ''FAILED'', job_name, ''STAGING'', f''POI staging failed. Error: {str(e)}'')
        return f''FAILED: {str(e)}''
';
CREATE OR REPLACE PROCEDURE "SP_STG_PERSON_ROLE_ASSIGNMENTS"()
RETURNS VARCHAR
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
ARTIFACT_REPOSITORY = snowflake.snowpark.pypi_shared_repository
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
EXECUTE AS CALLER
AS '
import uuid
from datetime import datetime
from snowflake.snowpark.functions import col, lit, trim, upper, coalesce, when, current_timestamp, concat_ws, sha2

def run(session):
    job_id = str(uuid.uuid4())
    job_name = ''STG_PERSON_ROLE_ASSIGNMENTS_LOAD''
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

        status = ''SUCCESS'' if rows_failed == 0 else ''PARTIAL_SUCCESS''
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), rows_processed, rows_failed, status, None)
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", status, job_name, ''STAGING'', f''PRA staging completed. Rows: {rows_processed}, Failed: {rows_failed}'')

        return f''SUCCESS: {rows_processed} rows loaded''

    except Exception as e:
        session.call("DCF_RAWDATA.AUDIT.SP_LOG_AUDIT", job_id, job_name, ''STAGING'', start_time, datetime.now(), 0, 1, ''FAILED'', str(e))
        session.call("DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION", ''FAILED'', job_name, ''STAGING'', f''PRA staging failed. Error: {str(e)}'')
        return f''FAILED: {str(e)}''
';