dROP TABLE PENALTY_REPORT_DATA_OUT
GO

cREATE tABLE PENALTY_REPORT_DATA_OUT 
(Difference	           INT
,reportmonth	       DATETIME
,DiffDatebyBE	       INT
,DATEDIFFCLOSE     INT
,DATEDIFFRESPONSE INT
,Response_Actual_KPI	INT
,Repair_Actual_KPI	 INT
,Repair_Actual_KPI_curr	INT
,Response_Day	INT
,wkr_mst_wr_no	VARCHAR(100)
,wkr_mst_org_date	datetime
,wkr_mst_originator	VARCHAR(100)
,ast_mst_asset_no	VARCHAR(100)
,BE_Category	 VARCHAR(100)
,ast_det_mfg_cd	VARCHAR(100)
,ast_det_modelno	VARCHAR(100)
,ast_det_asset_cost	NUMERIC(14,3)
,be_group	VARCHAR(100)
,ast_mst_asset_status	VARCHAR(100)
,wko_mst_descs	VARCHAR(2000)
,Clinic_Code	VARCHAR(100)
,Clinic_Name	VARCHAR(200)
,Clinic_Type	 VARCHAR(100)
,STATE	VARCHAR(100)
,District	VARCHAR(100)
,Circle	VARCHAR(100)
,Clinic_Category	VARCHAR(100)
,Zone	VARCHAR(100)
,Penalty_Cost	NUMERIC(10,3)
,Cli_Typ	VARCHAR(100)
,wko_mst_wo_no	VARCHAR(100)
,wko_mst_org_date	datetime
,Response_Date	datetime
,Acknowledge_date	datetime
,wko_det_corr_action	VARCHAR(2000)
,wko_det_cmpl_date	datetime
,wko_mst_status	VARCHAR(100)
,wko_det_assign_to	VARCHAR(100)
,[Response KPI] INT
,[Repair KPI]	INT
,Period_Status VARCHAR(100)
)