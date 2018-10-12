select 
ast_mst_asset_no ,
BE_Category ,
ast_det_mfg_cd,
ast_det_modelno,
be_group,
ast_mst_asset_status,
replace(replace(replace(wko_mst_descs,char(13),''),char(10),''),char(9),'') as wko_mst_descs,
Clinic_Code,
Clinic_Name,
Clinic_Type	,
STATE	,
District	,
Circle	,
Clinic_Category	,
Zone,
wkr_mst_originator,
wkr_mst_wr_no,
wkr_mst_org_date,
wko_mst_wo_no,
wko_mst_org_date,
Response_Date,
Acknowledge_date,
replace(replace(replace(wko_det_corr_action,char(13),''),char(10),''),char(9),'') as wko_det_corr_action,
wko_det_cmpl_date,
wko_mst_status,
wko_det_assign_to ,
ast_det_asset_cost,
[Response KPI],
Response_Actual_KPI,
[Repair KPI],
Repair_Actual_KPI ,
Penalty_Cost ,
DiffDatebyBE,
CONVERT(VARCHAR(3),DATENAME(mm,reportmonth)) AS MONTHNAME,
Period_Status 
 from PENALTY_REPORT_DATA_OUT (nolock)
 --where ast_mst_asset_no = 'SLR005978'

 --pkn


 --1698
 --2958

 ast_loc
 where ast_loc_state= 'WILAYAH PERSEKUTUAN'


 ast_mst
 where ast_mst_ast_lvl = 'WILAYAH PERSEKUTUAN'
 and ast_mst_asset_status = 'ACT'

  ast_mst
 where ast_mst_work_area = 'CC1'
 and ast_mst_asset_locn in ('KUALA LUMPUR','KERAMAT','JINJANG')

 ast_mst
 where ast_mst_asset_no like 'WKL%'
 and ast_mst_create_by <> 'Patch'
 and ast_mst_asset_status = 'ACT'