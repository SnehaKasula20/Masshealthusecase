create or replace schema AUDIT;

create or replace TABLE AUDIT_JOB_LOG (
	JOB_ID VARCHAR(16777216),
	JOB_NAME VARCHAR(16777216),
	LAYER_NAME VARCHAR(16777216),
	START_TIME TIMESTAMP_NTZ(9),
	END_TIME TIMESTAMP_NTZ(9),
	ROWS_PROCESSED NUMBER(38,0),
	ROWS_FAILED NUMBER(38,0),
	JOB_STATUS VARCHAR(16777216),
	ERROR_MESSAGE VARCHAR(16777216)
);
CREATE OR REPLACE PROCEDURE "SP_LOG_AUDIT"("JOB_ID" VARCHAR, "JOB_NAME" VARCHAR, "LAYER_NAME" VARCHAR, "START_TIME" TIMESTAMP_NTZ(9), "END_TIME" TIMESTAMP_NTZ(9), "ROWS_PROCESSED" NUMBER(38,0), "ROWS_FAILED" NUMBER(38,0), "JOB_STATUS" VARCHAR, "ERROR_MESSAGE" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 

BEGIN 

    INSERT INTO AUDIT.audit_job_log ( 

        job_id, job_name, layer_name, start_time, end_time, 

        rows_processed, rows_failed, job_status, error_message 

    ) 

    VALUES ( 

        :job_id, :job_name, :layer_name, :start_time, :end_time, 

        :rows_processed, :rows_failed, :job_status, :error_message 

    ); 

 

    RETURN ''AUDIT_LOG_INSERTED''; 

END; 

';