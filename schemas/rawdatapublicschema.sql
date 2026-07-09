create or replace schema PUBLIC;

create or replace TABLE TABLE_PK_CONFIG (
	TABLE_NAME VARCHAR(16777216),
	PK_COLUMN VARCHAR(16777216),
	HAS_CHECKSUM BOOLEAN
);
create or replace TABLE T_ALLOWABLE_VALUES (
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
	LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	primary key (AV_ID)
);
create or replace TABLE T_CASES (
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
	LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	primary key (CAS_ID)
);
create or replace TABLE T_CUSTODIES (
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
	LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	primary key (CUS_ID)
);
create or replace TABLE T_MEDICATIONS (
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
	LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	primary key (MED_ID)
);
create or replace TABLE T_MEDICATION_HEALTH_BEHAVIOR (
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
	LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	primary key (MHP_ID)
);
create or replace TABLE T_PERSONS (
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
	LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	primary key (PERSON_ID)
);
create or replace TABLE T_PERSON_ORG_INVOLVEMENT (
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
	LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	primary key (POI_ID)
);
create or replace TABLE T_PERSON_ROLE_ASSIGNMENTS (
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
	LOAD_TIMESTAMP TIMESTAMP_NTZ(9),
	SOURCE_FILE_NAME VARCHAR(16777216),
	primary key (PRA1_ID)
);
CREATE OR REPLACE FILE FORMAT CSV_FILE_FORMAT
	PARSE_HEADER = TRUE
	TRIM_SPACE = TRUE
	FIELD_OPTIONALLY_ENCLOSED_BY = '\"'
	NULL_IF = ('NULL', 'null', '')
	ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
;
CREATE OR REPLACE PROCEDURE "SP_LOAD_RAW_TABLE"("TABLE_NAME" VARCHAR, "FILE_NAME" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS CALLER
AS '

DECLARE

    job_id          STRING        DEFAULT UUID_STRING();
    start_time      TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP();
    sql_query       STRING;
    pk_column       STRING;
    last_loaded_ts  TIMESTAMP_NTZ;
    set_clause      STRING;
    col_list        STRING;
    rows_loaded     NUMBER        DEFAULT 0;
    rows_failed     NUMBER        DEFAULT 0;
    rows_inserted   NUMBER        DEFAULT 0;
    rows_updated    NUMBER        DEFAULT 0;
    copy_id         STRING;
    log_name        STRING;
    run_status      STRING;
    alert_msg       STRING;
    log_layer       STRING        DEFAULT ''RAWDATA'';
    raw_table       STRING        DEFAULT '''';
    has_checksum    BOOLEAN;
    merge_condition STRING;
    using_clause STRING;
    

BEGIN

    -- build unique temp table name per file to avoid conflicts
   raw_table := ''DCF_RAWDATA.PUBLIC.RAW_'' || table_name || ''_'' ||
             REPLACE(REPLACE(UPPER(file_name), ''.CSV'', ''''), ''-'', ''_'');

    -- fetch PK column and checksum flag
    sql_query :=
        ''SELECT PK_COLUMN, HAS_CHECKSUM '' ||
        ''FROM DCF_RAWDATA.PUBLIC.TABLE_PK_CONFIG '' ||
        ''WHERE UPPER(TABLE_NAME) = UPPER('''''' || table_name || '''''')'';
    EXECUTE IMMEDIATE sql_query;
    
    SELECT $1, $2
    INTO :pk_column, :has_checksum
    FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    IF (pk_column IS NULL) THEN
        RETURN ''FAILED | TABLE: '' || table_name || '' | ERROR: No PK config found'';
    END IF;

    -- fetch last loaded timestamp for this table
    sql_query :=
        ''SELECT LAST_SUCCESSFUL_WATERMARK '' ||
        ''FROM DCF_RAWDATA.CONFIG.ETL_WATERMARK '' ||
        ''WHERE UPPER(TABLE_NAME) = UPPER('''''' || table_name || '''''')'';
    EXECUTE IMMEDIATE sql_query;

    SELECT $1
    INTO :last_loaded_ts
    FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    

    -- build dynamic SET clause excluding PK
sql_query :=
    ''SELECT LISTAGG(''''t.'''' || COLUMN_NAME || '''' = s.'''' || COLUMN_NAME, '''', '''') '' ||
    ''WITHIN GROUP (ORDER BY ORDINAL_POSITION) '' ||
    ''FROM DCF_RAWDATA.INFORMATION_SCHEMA.COLUMNS '' ||
    ''WHERE TABLE_SCHEMA = ''''PUBLIC'''' '' ||
    ''AND TABLE_NAME = UPPER('''''' || table_name || '''''') '' ||
    ''AND COLUMN_NAME NOT IN ('' ||
    '''''''' || UPPER(pk_column) || '''''', '' ||
    ''''''LOAD_TIMESTAMP'''', '' ||
    ''''''SOURCE_FILE_NAME'''')'';
    EXECUTE IMMEDIATE sql_query;

    SELECT $1
    INTO :set_clause
    FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    -- build dynamic column list
    sql_query :=
    ''SELECT LISTAGG(COLUMN_NAME, '''', '''') WITHIN GROUP (ORDER BY ORDINAL_POSITION) '' ||
    ''FROM DCF_RAWDATA.INFORMATION_SCHEMA.COLUMNS '' ||
    ''WHERE TABLE_SCHEMA = ''''PUBLIC'''' '' ||
    ''AND TABLE_NAME = UPPER('''''' || table_name || '''''') '' ||
    ''AND COLUMN_NAME NOT IN (''''LOAD_TIMESTAMP'''', ''''SOURCE_FILE_NAME'''')'';
    EXECUTE IMMEDIATE sql_query;

    SELECT $1
    INTO :col_list
    FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));



    -- create raw temp table unique per file
    sql_query :=
        ''CREATE OR REPLACE TEMPORARY TABLE '' || raw_table ||
        '' LIKE DCF_RAWDATA.PUBLIC.'' || table_name;
    EXECUTE IMMEDIATE sql_query;

    -- copy CSV into raw temp table
    sql_query :=
        ''COPY INTO '' || raw_table || '' '' ||
        ''FROM @DCF_RAWDATA.RAWDATA.POSTGRES_STAGE/'' || table_name || ''/'' || file_name || '' '' ||
        ''FILE_FORMAT = (FORMAT_NAME = ''''DCF_RAWDATA.PUBLIC.CSV_FILE_FORMAT'''') '' ||
        ''MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE '' ||
        ''ON_ERROR = CONTINUE '' ||
        ''FORCE    = FALSE '' ||
        ''PURGE    = FALSE'';
    EXECUTE IMMEDIATE sql_query;

    copy_id := LAST_QUERY_ID();


    
    -- get copy counts
    sql_query :=
        ''SELECT COALESCE(SUM("rows_loaded"), 0), COALESCE(SUM("errors_seen"), 0) '' ||
        ''FROM TABLE(RESULT_SCAN('''''' || copy_id || ''''''))'';
    EXECUTE IMMEDIATE sql_query;

    SELECT $1, $2
    INTO :rows_loaded, :rows_failed
    FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    -- log failed rows from copy
    IF (rows_failed > 0) THEN
        sql_query :=
            ''INSERT INTO DCF_RAWDATA.CONFIG.ETL_FAILED_RECORDS '' ||
            ''(FILE_NAME, TABLE_NAME, ROW_DATA, ERROR_MESSAGE) '' ||
            ''SELECT '' ||
            ''    '''''' || file_name || '''''', '' ||
            ''    '''''' || table_name || '''''', '' ||
            ''    OBJECT_CONSTRUCT( '' ||
            ''        ''''file'''', "file", '' ||
            ''        ''''rows_parsed'''', "rows_parsed", '' ||
            ''        ''''rows_loaded'''', "rows_loaded", '' ||
            ''        ''''errors_seen'''', "errors_seen", '' ||
            ''        ''''first_error_line'''', "first_error_line", '' ||
            ''        ''''first_error_column_name'''', "first_error_column_name" '' ||
            ''    )::VARCHAR, '' ||
            ''    "first_error" '' ||
            ''FROM TABLE(RESULT_SCAN('''''' || copy_id || '''''')) '' ||
            ''WHERE "errors_seen" > 0'';
        EXECUTE IMMEDIATE sql_query;
    END IF;

    -- merge raw temp into RAW table using checksum for change detection
    
    IF (has_checksum) THEN
        merge_condition :=
            ''(t.CHECKSUM <> s.CHECKSUM
              OR (t.CHECKSUM IS NULL AND s.CHECKSUM IS NOT NULL)
              OR (t.CHECKSUM IS NOT NULL AND s.CHECKSUM IS NULL))'';
    ELSE
        merge_condition :=
            ''COALESCE(t.MOD_TS, t.ADD_TS) <> COALESCE(s.MOD_TS, s.ADD_TS)'';
    END IF;

    IF (last_loaded_ts IS NULL) THEN
    using_clause := raw_table;
    ELSE
    using_clause :=
        ''(SELECT * FROM '' || raw_table ||
        '' WHERE GREATEST('' ||
        ''ADD_TS::TIMESTAMP_NTZ, '' ||
        ''COALESCE(MOD_TS::TIMESTAMP_NTZ, ADD_TS::TIMESTAMP_NTZ)'' ||
        '') > '''''' || last_loaded_ts || '''''')'';
    END IF;
    
    -- merge into target table
    
    sql_query :=
        ''MERGE INTO DCF_RAWDATA.PUBLIC.'' || table_name || '' t '' ||
        ''USING '' || using_clause || '' s '' ||
        ''ON t.'' || pk_column || '' = s.'' || pk_column || '' '' ||
    
        ''WHEN MATCHED AND '' || merge_condition || '' '' ||
        ''THEN UPDATE SET '' ||
            set_clause ||
            '', t.LOAD_TIMESTAMP = CURRENT_TIMESTAMP()'' ||
            '', t.SOURCE_FILE_NAME = '''''' || file_name || '''''' '' ||
    
        ''WHEN NOT MATCHED THEN '' ||
        ''INSERT ('' || col_list || '', LOAD_TIMESTAMP, SOURCE_FILE_NAME) '' ||
        ''VALUES ('' || col_list || '', CURRENT_TIMESTAMP(), '''''' || file_name || '''''')'';
    
    EXECUTE IMMEDIATE sql_query;

    -- get inserted and updated counts
    sql_query :=
        ''SELECT "number of rows inserted", "number of rows updated" '' ||
        ''FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))'';
    EXECUTE IMMEDIATE sql_query;

    SELECT $1, $2
    INTO :rows_inserted, :rows_updated
    FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    rows_loaded := rows_inserted + rows_updated;

    -- drop temp table after merge
    sql_query := ''DROP TABLE IF EXISTS '' || raw_table;
    EXECUTE IMMEDIATE sql_query;

    -- update ETL_WATERMARK for this table
    sql_query :=
        ''MERGE INTO DCF_RAWDATA.CONFIG.ETL_WATERMARK t '' ||
        ''USING ( '' ||
        ''    SELECT '''''' || table_name || '''''' AS TABLE_NAME, '' ||
        ''           MAX(GREATEST(ADD_TS::TIMESTAMP_NTZ, COALESCE(MOD_TS::TIMESTAMP_NTZ, ADD_TS::TIMESTAMP_NTZ))) AS NEW_TS '' ||
        ''    FROM DCF_RAWDATA.PUBLIC.'' || table_name ||
        '') s '' ||
        ''ON t.TABLE_NAME = s.TABLE_NAME '' ||
        ''WHEN MATCHED THEN UPDATE SET '' ||
        ''    t.LAST_SUCCESSFUL_WATERMARK = s.NEW_TS, '' ||
        ''    t.LAST_FILE_NAME            = '''''' || file_name || '''''', '' ||
        ''    t.UPDATED_AT                = CURRENT_TIMESTAMP() '' ||
        ''WHEN NOT MATCHED THEN INSERT '' ||
        ''    (TABLE_NAME, LAST_SUCCESSFUL_WATERMARK, LAST_FILE_NAME) '' ||
        ''    VALUES (s.TABLE_NAME, s.NEW_TS, '''''' || file_name || '''''')'';
    EXECUTE IMMEDIATE sql_query;

    -- audit log
    log_name   := ''RAW_'' || UPPER(table_name) || ''_LOAD'';
    run_status := CASE WHEN rows_failed > 0 THEN ''PARTIAL_SUCCESS'' ELSE ''SUCCESS'' END;

    CALL DCF_RAWDATA.AUDIT.SP_LOG_AUDIT(
        :job_id,
        :log_name,
        :log_layer,
        :start_time,
        CURRENT_TIMESTAMP(),
        :rows_loaded,
        :rows_failed,
        :run_status,
        NULL
    );

    -- skip notification if nothing was loaded
    IF (rows_inserted = 0 AND rows_updated = 0 AND rows_failed = 0) THEN
        RETURN
            ''SUCCESS''       ||
            '' | TABLE: ''    || table_name    ||
            '' | INSERTED: '' || rows_inserted ||
            '' | UPDATED: ''  || rows_updated  ||
            '' | FAILED: ''   || rows_failed   ||
            '' | PK: ''       || pk_column;
    END IF;

    -- email notification
    alert_msg :=
        ''Table         : '' || table_name    || ''\\n'' ||
        ''File          : '' || file_name     || ''\\n'' ||
        ''Status        : '' || run_status    || ''\\n'' ||
        ''New Inserted  : '' || rows_inserted || ''\\n'' ||
        ''Updated       : '' || rows_updated  || ''\\n'' ||
        ''Total Loaded  : '' || rows_loaded   || ''\\n'' ||
        ''Copy Errors   : '' || rows_failed   || ''\\n'' ||
        ''Processed At  : '' || CURRENT_TIMESTAMP();

    CALL DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION(
        :run_status,
        :log_name,
        :log_layer,
        :alert_msg
    );

    RETURN
        ''SUCCESS''       ||
        '' | TABLE: ''    || table_name    ||
        '' | INSERTED: '' || rows_inserted ||
        '' | UPDATED: ''  || rows_updated  ||
        '' | FAILED: ''   || rows_failed   ||
        '' | PK: ''       || pk_column;

EXCEPTION
    WHEN OTHER THEN
        LET err_msg     := SQLERRM;
        log_name        := ''RAW_'' || UPPER(table_name) || ''_LOAD'';

        INSERT INTO DCF_RAWDATA.CONFIG.ETL_FAILED_RECORDS
            (FILE_NAME, TABLE_NAME, ERROR_MESSAGE)
        VALUES
            (:file_name, :table_name, :err_msg);

        CALL DCF_RAWDATA.AUDIT.SP_LOG_AUDIT(
            :job_id,
            :log_name,
            :log_layer,
            :start_time,
            CURRENT_TIMESTAMP(),
            0,
            1,
            ''FAILED'',
            :err_msg
        );

        LET fail_status STRING := ''FAILED'';
        LET fail_msg    STRING := :table_name || '' load failed. Error: '' || :err_msg;

        CALL DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION(
            :fail_status,
            :log_name,
            :log_layer,
            :fail_msg
        );

        RETURN
            ''FAILED''     ||
            '' | TABLE: '' || table_name ||
            '' | ERROR: '' || :err_msg;
END;
';
CREATE OR REPLACE PROCEDURE "SP_ORCHESTRATE_RAW_LOAD"()
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS CALLER
AS '

DECLARE

    stage_files  RESULTSET;
    table_name   STRING;
    file_name    STRING;
    result       STRING;
    total        NUMBER  DEFAULT 0;
    success      NUMBER  DEFAULT 0;
    failed       NUMBER  DEFAULT 0;
    summary      STRING  DEFAULT '''';
    pk_exists    NUMBER  DEFAULT 0;
    orch_status  STRING  DEFAULT '''';
    orch_job     STRING  DEFAULT ''ORCHESTRATE_RAW_LOAD'';
    orch_layer   STRING  DEFAULT ''RAWDATA'';
    orch_msg     STRING  DEFAULT '''';
    orch_return  STRING  DEFAULT '''';

BEGIN

    -- read all new files from stream ordered by oldest first
    stage_files := (
        SELECT
            SPLIT_PART(RELATIVE_PATH, ''/'', 1) AS TABLE_NAME,
            SPLIT_PART(RELATIVE_PATH, ''/'', 2) AS FILE_NAME
        FROM DCF_RAWDATA.RAWDATA.STREAM_POSTGRES_STAGE
        WHERE RELATIVE_PATH ILIKE ''%.csv''
        AND METADATA$ACTION = ''INSERT''
        ORDER BY LAST_MODIFIED ASC
    );

    FOR rec IN stage_files DO

        table_name := rec.TABLE_NAME;
        file_name  := rec.FILE_NAME;

        -- check if table exists in PK config
        SELECT COUNT(1)
        INTO :pk_exists
        FROM DCF_RAWDATA.PUBLIC.TABLE_PK_CONFIG
        WHERE UPPER(TABLE_NAME) = UPPER(:table_name);

        IF (pk_exists = 0) THEN
            summary := summary || ''\\n  SKIPPED | '' || table_name || '' | Not in PK config'';
            CONTINUE;
        END IF;

        total := total + 1;

        -- call load SP for this table
        CALL DCF_RAWDATA.PUBLIC.SP_LOAD_RAW_TABLE(:table_name, :file_name);

        SELECT $1
        INTO :result
        FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

        IF (result ILIKE ''SUCCESS%'') THEN
            success := success + 1;
        ELSE
            failed  := failed  + 1;
        END IF;

        summary := summary || ''\\n  '' || result;

    END FOR;

    -- return early if no valid tables found
    IF (total = 0) THEN
        RETURN ''No new files found. Nothing to process or the csv file does not exists in the TABLE_PK_CONFIG table.'';
    END IF;

    -- consume stream by storing latest file per table in watermark
    MERGE INTO DCF_RAWDATA.CONFIG.ETL_WATERMARK t
    USING (
        SELECT TABLE_NAME, FILE_NAME
        FROM (
            SELECT
                SPLIT_PART(RELATIVE_PATH, ''/'', 1) AS TABLE_NAME,
                SPLIT_PART(RELATIVE_PATH, ''/'', 2) AS FILE_NAME,
                ROW_NUMBER() OVER (
                    PARTITION BY SPLIT_PART(RELATIVE_PATH, ''/'', 1)
                    ORDER BY LAST_MODIFIED DESC
                ) AS RN
            FROM DCF_RAWDATA.RAWDATA.STREAM_POSTGRES_STAGE
            WHERE RELATIVE_PATH ILIKE ''%.csv''
            AND METADATA$ACTION = ''INSERT''
            AND SPLIT_PART(RELATIVE_PATH, ''/'', 1) IN (
                SELECT TABLE_NAME FROM DCF_RAWDATA.PUBLIC.TABLE_PK_CONFIG
            )
        )
        WHERE RN = 1
    ) s
    ON t.TABLE_NAME = s.TABLE_NAME
    WHEN MATCHED THEN UPDATE SET
        t.LAST_FILE_NAME = s.FILE_NAME,
        t.UPDATED_AT     = CURRENT_TIMESTAMP()
    WHEN NOT MATCHED THEN INSERT
        (TABLE_NAME, LAST_FILE_NAME)
        VALUES (s.TABLE_NAME, s.FILE_NAME);

    -- set status and notification message
    orch_status := CASE WHEN failed > 0 THEN ''PARTIAL'' ELSE ''SUCCESS'' END;
    orch_msg    :=
        ''Raw Load Orchestration Summary''  ||
        ''\\nTotal Tables : '' || total      ||
        ''\\nSuccess      : '' || success    ||
        ''\\nFailed       : '' || failed     ||
        ''\\n\\nDetails:''      || summary;

    CALL DCF_RAWDATA.UTIL.SP_SEND_PIPELINE_NOTIFICATION(
        :orch_status,
        :orch_job,
        :orch_layer,
        :orch_msg
    );

    orch_return :=
        ''ORCHESTRATION COMPLETE'' ||
        '' | TOTAL: ''   || total   ||
        '' | SUCCESS: '' || success ||
        '' | FAILED: ''  || failed  ||
        '' | DETAILS: '' || summary;

    RETURN :orch_return;

EXCEPTION
    WHEN OTHER THEN
        LET err_msg := SQLERRM;
        RETURN ''FAILED | ERROR: '' || :err_msg;
END;
';
create or replace stream STREAM_T_ALLOWABLE_VALUES on table T_ALLOWABLE_VALUES;
create or replace stream STREAM_T_CASES on table T_CASES;
create or replace stream STREAM_T_CUSTODIES on table T_CUSTODIES;
create or replace stream STREAM_T_MEDICATIONS on table T_MEDICATIONS;
create or replace stream STREAM_T_MEDICATION_HEALTH_BEHAVIOR on table T_MEDICATION_HEALTH_BEHAVIOR;
create or replace stream STREAM_T_PERSONS on table T_PERSONS;
create or replace stream STREAM_T_PERSON_ORG_INVOLVEMENT on table T_PERSON_ORG_INVOLVEMENT;
create or replace stream STREAM_T_PERSON_ROLE_ASSIGNMENTS on table T_PERSON_ROLE_ASSIGNMENTS;
create or replace task TASK_RAW_ORCHESTRATE
	warehouse=COMPUTE_WH
	schedule='1 MINUTE'
	when SYSTEM$STREAM_HAS_DATA('DCF_RAWDATA.RAWDATA.STREAM_POSTGRES_STAGE')
	as CALL DCF_RAWDATA.PUBLIC.SP_ORCHESTRATE_RAW_LOAD();