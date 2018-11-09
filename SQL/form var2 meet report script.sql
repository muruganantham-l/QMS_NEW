--insert additional_equipment_list_kl (be_number)
--SELECT * from kl_meet

update  additional_equipment_list_kl
set  month_year = '01/08/2018'
,start_service_date = '01/09/2018'


update t set state1 = 
ast_mst_ast_lvl
,district = ast_mst_asset_locn
,clinic = ast_det_note1
,be_category = ast_mst_asset_longdesc
,serial_number = ast_det_varchar2
,manufacturer = d.ast_det_mfg_cd
,model = d.ast_det_modelno
,purchase_cost = ast_det_asset_cost
,maintenance_rate = ast_det_numeric1
,monthly_fee = ast_det_numeric8
,extra1 = convert(varchar,d.ast_det_purchase_date,103)
,extra2 = d.ast_det_cus_code
from additional_equipment_list_kl t 
join ast_mst m on m.ast_mst_asset_no = t.be_number
join ast_det d on m.RowID = d.mst_RowID


SELECT * from additional_equipment_list_kl where be_number
= 'SLR030584'