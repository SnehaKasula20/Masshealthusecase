TRUNCATE TABLE DCF_RAWDATA.DWH.DIM_CASES_INFO;
TRUNCATE TABLE DCF_RAWDATA.DWH.DIM_CUSTODIES_INFO;
TRUNCATE TABLE DCF_RAWDATA.DWH.DIM_MEDICATIONS_INFO;
TRUNCATE TABLE DCF_RAWDATA.DWH.DIM_MEDICATION_HEALTH_BEHAVIOR_INFO;
TRUNCATE TABLE DCF_RAWDATA.DWH.DIM_PERSON_ORG_INVOLVEMENT_INFO;
TRUNCATE TABLE DCF_RAWDATA.DWH.DIM_PERSON_ROLE_ASSIGNMENTS_INFO;
TRUNCATE TABLE DCF_RAWDATA.DWH.DIM_T_PERSONS;

TRUNCATE TABLE DCF_RAWDATA.DWH.FACT_CASES;
TRUNCATE TABLE DCF_RAWDATA.DWH.FACT_CUSTODIES;
TRUNCATE TABLE DCF_RAWDATA.DWH.FACT_MEDICATIONS;
TRUNCATE TABLE DCF_RAWDATA.DWH.FACT_MEDICATION_HEALTH_BEHAVIOR;
TRUNCATE TABLE DCF_RAWDATA.DWH.FACT_PERSON_ORG_INVOLVEMENT;
TRUNCATE TABLE DCF_RAWDATA.DWH.FACT_PERSON_ROLE_ASSIGNMENTS;

select * from dcf_rawdata.staging.stg_medications




select * from DCF_RAWDATA.DWH.DIM_MEDICATIONS_INFO


select * from DCF_RAWDATA.DWH.DIM_MEDICATION_HEALTH_BEHAVIOR_INFO where 












select * from dcf_rawdata.public.T_MEDICATIONS






     CREATE OR REPLACE NOTEBOOK PROJECT DCF_RAWDATA.UTIL.STAGING_PROJECT
  FROM 'snow://workspace/DCF_RAWDATA.PUBLIC."Masshealthusecase"/versions/live/'
  COMMENT = 'Runs all staging and dwh load notebook'

  CREATE OR REPLACE NOTEBOOK PROJECT DCF_RAWDATA.UTIL.STAGING_PROJECT
FROM 'snow://workspace/USER$.PUBLIC."Masshealthusecase"/versions/head/'
COMMENT = 'Runs all staging and DWH load notebooks';



snow://workspace/USER$.PUBLIC."Masshealthusecase"/versions/head/DWH/final_pipeline.ipynb
create or replace task DCF_RAWDATA.util.MAIN_TASK
	warehouse=COMPUTE_WH
	schedule='5 MINUTE'
	as EXECUTE NOTEBOOK PROJECT DCF_RAWDATA.UTIL.STAGING_PROJECT
    MAIN_FILE = 'DWH/final_pipeline.ipynb'
    COMPUTE_POOL = 'SYSTEM_COMPUTE_POOL_CPU'
    QUERY_WAREHOUSE = 'COMPUTE_WH'
    RUNTIME = 'V2.2-CPU-PY3.12';


    EXECUTE TASK DCF_RAWDATA.UTIL.main_task
    
    ALTER TASK DCF_RAWDATA.util.MAIN_TASK RESUME;

    select * from dcf_rawdata.dwh.dim_medication_health_behavior_info 

    select * from dcf_rawdata.staging.stg_medication_health_behavior where administer_method_code=100455

    select * from dcf_rawdata.dwh.fact_medication_health_behavior where MHP_ID=3055


    select * from dcf_rawdata.staging.stg_medication_health_behavior where mhp_id=3055

    select * from dwh.dim_cases_info


    
select * from audit.audit_job_log order by layer_name


select * from staging.stg_allowable_values where av_id=98886
    
select * from dcf_rawdata.dwh.fact_medications



CREATE OR REPLACE TASK DCF_RAWDATA.UTIL.TASK_RAW_ORCHESTRATE
  WAREHOUSE = 'COMPUTE_WH'
  SCHEDULE = '5 MINUTE'
  WHEN SYSTEM$STREAM_HAS_DATA('DCF_RAWDATA.RAWDATA.STREAM_POSTGRES_STAGE')
AS
  CALL DCF_RAWDATA.PUBLIC.SP_ORCHESTRATE_RAW_LOAD()


  

CREATE OR REPLACE TASK DCF_RAWDATA.UTIL.MAIN_TASK
  WAREHOUSE = 'COMPUTE_WH'
  AFTER DCF_RAWDATA.UTIL.TASK_RAW_ORCHESTRATE
AS
  EXECUTE NOTEBOOK PROJECT DCF_RAWDATA.UTIL.STAGING_PROJECT
    MAIN_FILE = 'DWH/final_pipeline.ipynb'
    COMPUTE_POOL = 'SYSTEM_COMPUTE_POOL_CPU'
    QUERY_WAREHOUSE = 'COMPUTE_WH'
    RUNTIME = 'V2.7-CPU-PY3.12';


ALTER TASK DCF_RAWDATA.UTIL.MAIN_TASK resume;
ALTER TASK DCF_RAWDATA.UTIL.TASK_RAW_ORCHESTRATE resume;


select * from config.etl_failed_records
select * from audit.audit_job_log