create or replace schema RAWDATA;

CREATE OR REPLACE STAGE POSTGRES_STAGE;

create or replace stream STREAM_POSTGRES_STAGE on directory(@POSTGRES_STAGE);