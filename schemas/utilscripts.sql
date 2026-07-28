create or replace schema UTIL;

CREATE OR REPLACE PROCEDURE "SP_SEND_PIPELINE_NOTIFICATION"("STATUS" VARCHAR, "JOB_NAME" VARCHAR, "LAYER_NAME" VARCHAR, "MESSAGE" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 

DECLARE 

    v_subject STRING; 

    v_body STRING; 

BEGIN 

    v_subject := ''DCF Pipeline - '' || :status || '' - '' || :job_name; 

 

    v_body := 

        ''Status: '' || :status || CHR(10) || 

        ''Job Name: '' || :job_name || CHR(10) || 

        ''Layer: '' || :layer_name || CHR(10) || 

        ''Message: '' || :message || CHR(10) || 

        ''Timestamp: '' || CURRENT_TIMESTAMP(); 

 

    CALL SYSTEM$SEND_EMAIL( 

        ''RETAIL_ETL_EMAIL_INT'', 

        ''skasula@defteam.com'', 

        :v_subject, 

        :v_body 

    ); 

 

    RETURN ''NOTIFICATION_SENT''; 

EXCEPTION 

    WHEN OTHER THEN 

        RETURN ''NOTIFICATION_FAILED: '' || SQLERRM; 

END; 

';

