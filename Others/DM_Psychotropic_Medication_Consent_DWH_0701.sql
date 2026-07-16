WITH REPORT_PERIOD AS
     (SELECT TO_TIMESTAMP('01/01/2025 00:00:00', 'MM/DD/YYYY HH24:MI:SS') REPORT_START_DATE,
             current_TIMESTAMP()   REPORT_END_DATE
      FROM DUAL
     ),
/* Medication Health Data the includes health behaviour, medication details, patient info along with filter to fetch only 'Consumer Child'  */
MED_HEALTH_DATA AS
     (SELECT 
            MHP_ID,  -- Key column to identify the record
            MED_MED_ID,
            MEDICATION_START_DATE,
            THRIVE_FAILURE_IND,
            PERSON_PRESCRIBER_ID,
            PERSON_PRESCRIBER_NAME,
            MEDICATION_CMNT,
            MHB_ADD_USER,
            MHB_ADD_TS,
            MHB_ADD_PERSON_ID,
            MHB_ADD_PERSON_NAME,
            MHB_ADD_ORGN_ID,
            INITCAP(MHB_ADD_ORGN_NAME) MHB_ADD_ORGN_NAME,
            MHB_MOD_USER,
            MHB_MOD_TS,
            MHB_MOD_PERSON_ID,
            MHB_MOD_PERSON_NAME,
            MHB_MOD_ORGN_ID,
            INITCAP(MHB_MOD_ORGN_NAME) MHB_MOD_ORGN_NAME,
            MEDICATION_END_DATE,
            PRESCRIBED_FREQUENCY_CODE_AV_ID,
            PRESCRIBED_FREQUENCY_CODE_DESC,
            DOSAGE_DESC,
            ADMINISTER_METHOD_CODE_AV_ID,
            ADMINISTER_METHOD_CODE_DESC,
            PERSON_PATIENT_ID,
            PERSON_PATIENT_NAME,
            PATIENT_BIRTH_DATE,
            PATIENT_GENDER_AV_ID,
            PATIENT_GENDER_CODE_DESC,
            CURRENT_AGE,
            CASE WHEN CURRENT_AGE > 24 THEN 24 
            ELSE CURRENT_AGE END PATIENT_AGE,
            DATE_UNKNOWN,
            PRESCRIBER_PCS_PCS_ID,
            LAST_REFILL_DATE,
            CLN_RESP_ADVERSE_EFFECT_CMNT,
            CONSENT_DATE,
            MHP_REPORT_DATE,
            CONSENT_DECISION_CODE_AV_ID,
            CONSENT_DECISION_CODE_DESC,
            CONSENT_BY_PERSON_ID,
            CONSENT_BY_PERSON_NAME,
            CONSENT_COMMENTS,
            MED_ID,
            MEDICATION_NAME,
            ROGER_DECISION_DRUG_IND,
            -- Updated logic shared by Ajay to determine if medication is antipsychotic or not based on classification code and Roger's decision
                CASE
              When Upper( ROGER_DECISION_DRUG_IND) = 'Y' then
                'Antipsychotic Drug'
              When ( Upper( COALESCE(ROGER_DECISION_DRUG_IND, 'N')) <> 'Y'
                 AND
                     MEDICATION_CLASSIFICATION_CODE_AV_ID = '169409' -- Pediatric Psychotherapeutic Drug
                   ) THEN
                'Non-Antipsychotic Drug'
              Else
                Null
            END PSYCHOTHERAPEUTIC_MED_SUBCLASS,
            -- Below dates column are from Medication table to track when the medication record was added and modified in the system
            MED_ADD_TS,
            MED_ADD_USER,
            MED_MOD_TS,
            MED_MOD_USER,

            MEDICATION_DESC,
            ALLOW_FREQUENCY_NUM,
            MEDICATION_CLASSIFICATION_CODE_AV_ID,
            MEDICATION_CLASSIFICATION_CODE_DESC
            -- REPORT_START_DATE and REPORT_END_DATE should not used in the select list.
     FROM (
      SELECT
MHP_ID,
MED_MED_ID,
START_DATE MEDICATION_START_DATE,
THRIVE_FAILURE_IND,
PERSON_PERSON_PRESCRIBER_ID PERSON_PRESCRIBER_ID,
PERSON_PERSON_PRESCRIBER_ID PERSON_PRESCRIBER_NAME,
MEDICATION_CMNT,
FMHB.ADD_USER                                 MHB_ADD_USER,
FMHB.ADD_TS                                   MHB_ADD_TS,
FMHB.ADD_PERSON_ID MHB_ADD_PERSON_ID,
FMHB.ADD_PERSON_ID MHB_ADD_PERSON_NAME,
FMHB.ADD_ORGN_ID MHB_ADD_ORGN_ID,
FMHB.ADD_ORGN_ID MHB_ADD_ORGN_NAME,
FMHB.MOD_USER                                 MHB_MOD_USER,
FMHB.MOD_TS                                   MHB_MOD_TS,
FMHB.MOD_PERSON_ID MHB_MOD_PERSON_ID,
FMHB.MOD_PERSON_ID MHB_MOD_PERSON_NAME,
FMHB.MOD_ORGN_ID MHB_MOD_ORGN_ID,
FMHB.MOD_ORGN_ID MHB_MOD_ORGN_NAME,
END_DATE MEDICATION_END_DATE,
PRESCRIBED_FREQUENCY_CODE_AV_ID,
PRESCRIBED_FREQUENCY_CODE_DESC,
DOSAGE_DESC,
ADMINISTER_METHOD_CODE_AV_ID,
ADMINISTER_METHOD_CODE_DESC,
PERSON_PERSON_PATIENT_ID PERSON_PATIENT_ID,
PERSON_PERSON_PATIENT_ID PERSON_PATIENT_NAME,
per.BIRTH_DATE PATIENT_BIRTH_DATE,
per.GENDER_CODE_AV_ID PATIENT_GENDER_AV_ID,
per.GENDER_CODE_DESC PATIENT_GENDER_CODE_DESC,
per.CURRENT_AGE,  -- Precalculated age based on birth date and current date of the ETL run
DATE_UNKNOWN,
PRESCRIBER_PCS_PCS_ID,
LAST_REFILL_DATE,
CLN_RESP_ADVERSE_EFFECT_CMNT,
CONSENT_DATE,
DATE_TRUNC('DAY',COALESCE(CONSENT_DATE,FMHB.ADD_TS)) MHP_REPORT_DATE, -- This is the report date to filter the records within the report period
CONSENT_DECISION_CODE_AV_ID,
CONSENT_DECISION_CODE_DESC,
CONSENT_BY_PERSON_PERSON_ID CONSENT_BY_PERSON_ID,
CONSENT_BY_PERSON_PERSON_ID CONSENT_BY_PERSON_NAME, 
CONSENT_COMMENTS,
MED_ID,
COMMON_NAME MEDICATION_NAME,
ROGER_DECISION_DRUG_IND,
FM.ADD_TS MED_ADD_TS,
FM.ADD_USER MED_ADD_USER,
FM.MOD_TS MED_MOD_TS,
FM.MOD_USER MED_MOD_USER,
MEDICATION_DESC,
ALLOW_FREQUENCY_NUM,
FM.ADD_PERSON_ID,
FM.ADD_ORGN_ID,
FM.MOD_PERSON_ID,
FM.MOD_ORGN_ID,
MEDICATION_CLASSIFICATION_CODE_AV_ID,
MEDICATION_CLASSIFICATION_CODE_DESC
        FROM FACT_MEDICATION_HEALTH_BEHAVIOR FMHB
         INNER JOIN DIM_MEDICATION_HEALTH_BEHAVIOR_INFO FMHBI
         ON FMHB.MEDICATION_HEALTH_BEHAVIOR_INFO_ID = FMHBI.MEDICATION_HEALTH_BEHAVIOR_INFO_ID
         INNER JOIN FACT_MEDICATIONS FM ON FMHB.MED_MED_ID = FM.MED_ID
         INNER JOIN DIM_MEDICATIONS_INFO DMI ON FM.MEDICATIONS_INFO_ID = DMI.MEDICATIONS_INFO_ID
         LEFT JOIN DIM_T_PERSONS per ON (FMHB.PERSON_PERSON_PATIENT_ID = PER.PERSON_ID)
         WHERE 
        FMHB.DELETED_DATE IS NULL 
        AND FMHBI.DELETED_DATE IS NULL AND FMHBI.UPDATED_DATE IS NULL
        AND FM.DELETED_DATE IS NULL
        AND DMI.DELETED_DATE IS NULL AND DMI.UPDATED_DATE IS NULL
        AND PER.DELETED_DATE IS NULL AND PER.UPDATED_DATE IS NULL
     ) MHBM
            CROSS JOIN REPORT_PERIOD rp 
            -- MHP_REPORT_DATE (fetching the consent date, if not use ADD_TS) -  filter to get the records within the report period                    
            WHERE MHBM.MHP_REPORT_DATE <= rp.REPORT_END_DATE
            AND MHBM.MHP_REPORT_DATE >= rp.REPORT_START_DATE
        AND EXISTS
        (SELECT 'x'
            FROM FACT_PERSON_ORG_INVOLVEMENT POI
                INNER JOIN FACT_PERSON_ROLE_ASSIGNMENTS PRA 
                ON POI.POI_ID = PRA.POI_POI_ID
                INNER JOIN DIM_PERSON_ROLE_ASSIGNMENTS_INFO DPR 
                ON PRA.PERSON_ROLE_ASSIGNMENTS_INFO_ID = DPR.PERSON_ROLE_ASSIGNMENTS_INFO_ID
            WHERE POI.PERSON_PERSON_ID = MHBM.PERSON_PATIENT_ID
                    AND DPR.ROLE_TYPE_AV_ID IN ('101491', '101581') -- Collateral, Collateral-Non DCF
                    AND NOT (   rp.REPORT_END_DATE < poi.start_date
                            OR NVL (poi.end_date, rp.REPORT_END_DATE) < rp.REPORT_START_DATE)
            AND POI.DELETED_DATE IS NULL
            AND PRA.DELETED_DATE IS NULL
            AND DPR.DELETED_DATE IS NULL AND DPR.UPDATED_DATE IS NULL
        )
),
CUSTODY_DATA AS (
      SELECT CUS_ID,
      PERSON_PERSON_CHILD_ID,
      LEGAL_STATUS_CODE_AV_ID,
      LEGAL_STATUS_CODE_DESC,
      CUSTODY_TYPE_AV_ID,
      CUSTODY_TYPE_DESC,
      CUSTODY_START_DATE,
      CUSTODY_END_DATE
      FROM (SELECT CUS_ID,
                  PERSON_PERSON_CHILD_ID,
                  DCI.LEGAL_STATUS_CODE_AV_ID,
                  DCI.LEGAL_STATUS_CODE_DESC,
                  START_DATE      CUSTODY_START_DATE,
                  END_DATE        CUSTODY_END_DATE,
                  DCI.CUSTODY_TYPE_AV_ID,
                  DCI.CUSTODY_TYPE_DESC,
                  RANK ()
                  OVER (PARTITION BY PERSON_PERSON_CHILD_ID
                        ORDER BY END_DATE DESC, START_DATE DESC, CUS_ID DESC)    CUSTODY_RNK
            FROM FACT_CUSTODIES FC 
            INNER JOIN DIM_CUSTODIES_INFO DCI 
            ON FC.CUSTODIES_INFO_ID = DCI.CUSTODIES_INFO_ID
            WHERE DCI.DELETED_DATE IS NULL AND DCI.UPDATED_DATE IS NULL
              AND FC.DELETED_DATE IS NULL
      )
      WHERE CUSTODY_RNK = 1
),
/* Get the most recent case for each person an alternative to SF_GET_CASE_4_PERSON */
PERSON_ORG_INV as
(
SELECT 
poi.POI_ID,
poi.PERSON_PERSON_ID,
poi.CAS_CAS_ID,
poi.START_DATE,
poi.END_DATE
from FACT_Person_Org_Involvement poi
INNER JOIN FACT_PERSON_ROLE_ASSIGNMENTS PRA 
ON POI.POI_ID = PRA.POI_POI_ID
INNER JOIN DIM_PERSON_ROLE_ASSIGNMENTS_INFO DPR 
ON PRA.PERSON_ROLE_ASSIGNMENTS_INFO_ID = DPR.PERSON_ROLE_ASSIGNMENTS_INFO_ID
where  poi.Cas_cas_id is not null
       And (
               poi.CAS_CAS_ID Not in
               ( '150282', -- Adoption Legalized with Subsidy (placeholder - not in current data)
                 '153053', -- Adoption Legalized without Subsidy
                 '153052', -- Guardianship Subsidy
                 '152792'  -- Institutional Abuse
               )
            
           )
       And ( DPR.ROLE_TYPE_AV_ID in
                ( '101491', '101581'  -- Collateral, Collateral-Non DCF
               )
       )
and poi.deleted_date is null
and pra.deleted_date is null
and dpr.deleted_date is null and dpr.updated_date is null
),
CASE_INFO AS (
      SELECT 
      CAS_ID,
      C.CASE_NAME,
      CASE_TYPE_AV_ID,
      CASE_TYPE_DESC,
      UNIT_ORGN_ID,
      UNIT_ORGN_ID UNIT_ORGN_NAME,
      AREA_ORGN_ID,
      AREA_ORGN_ID AREA_ORGN_NAME,
      REGION_ORGN_ID,
      REGION_ORGN_ID REGION_ORGN_NAME,
      CURRENT_CASE_STATUS_CODE_AV_ID,
      CURRENT_CASE_STATUS_CODE_DESC,
      CURRENT_CASE_STATUS_DATE
      FROM FACT_CASES C 
      INNER JOIN DIM_CASES_INFO DCI 
      ON C.CASES_INFO_ID = DCI.CASES_INFO_ID
      WHERE C.DELETED_DATE IS NULL
      AND DCI.DELETED_DATE IS NULL AND DCI.UPDATED_DATE IS NULL 
),
/* Case Assignment – one worker per case per ADD_TS date  */ --SF_GET_CASE_WORKER_ID
CASE_ASSIGNMENT AS (
    SELECT
        spoa.CAS_CAS_ID,
        spoa.SP_SP_ID                   CASE_WORKER_ID,
        spoa.assignment_start_date,
        spoa.assignment_end_date
    FROM fact_staff_person_office_assigns spoa
    JOIN dim_staff_person_office_assigns_info dpoa
         ON dpoa.staff_person_office_assigns_info_id =
            spoa.staff_person_office_assigns_info_id
        AND dpoa.assignment_type_av_id = '97982' -- Primary
        AND spoa.DELETED_DATE IS NULL
        AND dpoa.DELETED_DATE IS NULL AND dpoa.UPDATED_DATE IS NULL
)
SELECT 
FIN.*  --Remove RN_CA and RN_POI column from main select as they are only used for filtering the most recent record for each case and person
 FROM (
SELECT
RES.*,
        CA.CASE_WORKER_ID,
        CA.CASE_WORKER_ID CASE_WORKER_NAME,
            ROW_NUMBER() OVER (
    PARTITION BY RES.MHP_ID,RES.CAS_ID
    ORDER BY
        CA.assignment_end_date DESC NULLS FIRST,
        CA.assignment_start_date DESC ) RN_CA
FROM (
    SELECT 
        MHP_ID,
        MED_MED_ID,
        MHP_REPORT_DATE,
        MEDICATION_START_DATE,
        THRIVE_FAILURE_IND,
        MHD.PERSON_PRESCRIBER_ID,
        MHD.PERSON_PRESCRIBER_NAME,
        MEDICATION_CMNT,
        MHB_ADD_USER,
        MHB_ADD_TS,
        MHB_ADD_PERSON_ID,
        MHB_ADD_PERSON_NAME,
        MHB_ADD_ORGN_ID,
        MHB_ADD_ORGN_NAME,
        MHB_MOD_USER,
        MHB_MOD_TS,
        MHB_MOD_PERSON_ID,
        MHB_MOD_PERSON_NAME,
        MHB_MOD_ORGN_ID,
        MHB_MOD_ORGN_NAME,
        MEDICATION_END_DATE,
        PRESCRIBED_FREQUENCY_CODE_AV_ID,
        PRESCRIBED_FREQUENCY_CODE_DESC,
        DOSAGE_DESC,
        ADMINISTER_METHOD_CODE_AV_ID,
        ADMINISTER_METHOD_CODE_DESC,
        PERSON_PATIENT_ID,
        PERSON_PATIENT_NAME,
        PATIENT_BIRTH_DATE,
        PATIENT_GENDER_AV_ID,
        PATIENT_GENDER_CODE_DESC,
        CURRENT_AGE,
        PATIENT_AGE,
          CASE
            WHEN ( MHD.PATIENT_AGE >= 0
                   AND MHD.PATIENT_AGE < 3 ) THEN
                '( 0-2yrs )'
            WHEN MHD.PATIENT_AGE >= 3
                 AND MHD.PATIENT_AGE < 6 THEN
                '( 3-5yrs )'
            WHEN MHD.PATIENT_AGE >= 6
                 AND MHD.PATIENT_AGE < 12 THEN
                '( 6-11yrs )'
            WHEN MHD.PATIENT_AGE >= 12
                 AND MHD.PATIENT_AGE < 18 THEN
                '( 12-17yrs )'
            WHEN MHD.PATIENT_AGE >= 18
                 AND MHD.PATIENT_AGE < 22 THEN
                '( 18-21yrs )'
            WHEN MHD.PATIENT_AGE >= 22 THEN
                '( 22 or older )'
            WHEN MHD.PATIENT_AGE IS NULL
                 OR MHD.PATIENT_AGE < 0 THEN
                'Unspecified'
        END     PATIENT_AGE_GROUP,
        CASE
            WHEN ( MHD.PATIENT_AGE >= 0
                   AND MHD.PATIENT_AGE < 3 ) THEN
                1
            WHEN MHD.PATIENT_AGE >= 3
                 AND MHD.PATIENT_AGE < 6 THEN
                2
            WHEN MHD.PATIENT_AGE >= 6
                 AND MHD.PATIENT_AGE < 12 THEN
                3
            WHEN MHD.PATIENT_AGE >= 12
                 AND MHD.PATIENT_AGE < 18 THEN
                4
            WHEN MHD.PATIENT_AGE >= 18
                 AND MHD.PATIENT_AGE < 22 THEN
                5
            WHEN MHD.PATIENT_AGE >= 22 THEN
                6
            WHEN MHD.PATIENT_AGE IS NULL
                 OR MHD.PATIENT_AGE < 0 THEN
                9
            ELSE
                99
        END     PATIENT_AGE_GROUP_SORT,
        DATE_UNKNOWN,
        PRESCRIBER_PCS_PCS_ID,
        LAST_REFILL_DATE,
        CLN_RESP_ADVERSE_EFFECT_CMNT,
        CONSENT_DATE,
        CONSENT_DECISION_CODE_AV_ID,
        CONSENT_DECISION_CODE_DESC,
        CONSENT_BY_PERSON_ID,
        CONSENT_BY_PERSON_NAME,
        CONSENT_COMMENTS,
        MED_ID,
        MEDICATION_NAME,
        ROGER_DECISION_DRUG_IND,
        PSYCHOTHERAPEUTIC_MED_SUBCLASS,
        MED_ADD_TS,
        MED_ADD_USER,
        MED_MOD_TS,
        MED_MOD_USER,
        MEDICATION_DESC,
        ALLOW_FREQUENCY_NUM,
        MEDICATION_CLASSIFICATION_CODE_AV_ID,
        MEDICATION_CLASSIFICATION_CODE_DESC,
        CI.CAS_ID,
        CI.CASE_NAME,
        CASE_TYPE_AV_ID,
        CASE_TYPE_DESC,
        UNIT_ORGN_ID,
        UNIT_ORGN_NAME,
        AREA_ORGN_ID,
        AREA_ORGN_NAME,
        REGION_ORGN_ID,
        REGION_ORGN_NAME,
        Current_Case_Status_CODE_AV_ID,
        Current_Case_Status_CODE_DESC,
        Current_Case_Status_DATE,
        CD.CUS_ID,     
        CD.LEGAL_STATUS_CODE_AV_ID,
        CD.LEGAL_STATUS_CODE_DESC,
        CD.CUSTODY_TYPE_AV_ID,
        CD.CUSTODY_TYPE_DESC,
        CD.CUSTODY_START_DATE,
        CD.CUSTODY_END_DATE,
        ROW_NUMBER() OVER (
    PARTITION BY MHD.MHP_ID, POI.PERSON_PERSON_ID
    ORDER BY
        poi.end_date DESC NULLS FIRST,
        poi.start_date ) RN_POI
      FROM MED_HEALTH_DATA MHD
        LEFT JOIN CUSTODY_DATA CD 
             ON (CD.PERSON_PERSON_CHILD_ID = MHD.PERSON_PATIENT_ID)
        LEFT JOIN PERSON_ORG_INV POI ON (POI.PERSON_PERSON_ID = MHD.PERSON_PATIENT_ID
            and DATE_TRUNC('DAY',poi.start_date) <= COALESCE(MHD.MHB_ADD_TS, CURRENT_TIMESTAMP) )
        LEFT JOIN CASE_INFO CI ON (CI.CAS_ID = POI.CAS_CAS_ID)
        ) RES
    LEFT JOIN CASE_ASSIGNMENT CA
        ON CA.CAS_CAS_ID = RES.CAS_ID
            AND TO_DATE(CA.assignment_start_date) <= CURRENT_TIMESTAMP
        WHERE RES.RN_POI = 1
    ) FIN 
       WHERE FIN.RN_CA = 1
ORDER BY MHP_ID


