  SELECT DISTINCT
        c.CASE_TYPE AS CASE_TYPE_AV_ID,
        av1.VALUE_SHORT_DESC AS CASE_TYPE_DESC,
        c.CURRENT_CASE_STATUS_CODE AS CURRENT_CASE_STATUS_CODE_AV_ID,
        av2.VALUE_SHORT_DESC AS CURRENT_CASE_STATUS_CODE_DESC,
        c.RESTRICTION_REASON_CODE AS RESTRICTION_REASON_CODE_AV_ID,
        av3.VALUE_SHORT_DESC AS RESTRICTION_REASON_CODE_DESC,
        c.DELETED_DATE,
        SHA2(CONCAT_WS('|',
            COALESCE(TO_VARCHAR(c.CASE_TYPE), ''),
            COALESCE(av1.VALUE_SHORT_DESC, ''),
            COALESCE(TO_VARCHAR(c.CURRENT_CASE_STATUS_CODE), ''),
            COALESCE(av2.VALUE_SHORT_DESC, ''),
            COALESCE(TO_VARCHAR(c.RESTRICTION_REASON_CODE), ''),
            COALESCE(av3.VALUE_SHORT_DESC, ''),
            COALESCE(TO_VARCHAR(c.DELETED_DATE), '')
        )) AS CHECKSUM
    FROM STAGING.STG_CASES c
    LEFT JOIN STAGING.STG_ALLOWABLE_VALUES av1
        ON c.CASE_TYPE = av1.AV_ID
    LEFT JOIN STAGING.STG_ALLOWABLE_VALUES av2
        ON c.CURRENT_CASE_STATUS_CODE = av2.AV_ID
    LEFT JOIN STAGING.STG_ALLOWABLE_VALUES av3
        ON c.RESTRICTION_REASON_CODE = av3.AV_ID


select * from staging.stg_cases
select * from staging.stg_allowable_values where av_id=106374

select * from staging.invalid_records


ALTER TASK DCF_RAWDATA.UTIL.MAIN_TASK suspend;
ALTER TASK DCF_RAWDATA.UTIL.TASK_RAW_ORCHESTRATE suspend;


select * from dcf_rawdata.config.etl_failed_records
select * from dcf_rawdata.rawdata.stream_postgres_stage


select * from audit.audit_job_log order by start_time desc

SELECT GET_DDL('SCHEMA', 'DCF_RAWDATA.PUBLIC');