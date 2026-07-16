 CREATE OR REPLACE NOTEBOOK PROJECT DCF_RAWDATA.UTIL.STAGING_PROJECT
FROM 'snow://workspace/USER$.PUBLIC."Masshealthusecase"/versions/head/'
COMMENT = 'Runs all staging and DWH load notebooks';