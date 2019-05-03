update d set  
d.prm_det_chg_costcenter	= a.ast_mst_cost_center
,d.prm_det_asset_level		= a.ast_mst_ast_lvl
,d.prm_det_work_area		= a.ast_mst_work_area
,d.prm_det_customer_cd		= b.ast_det_cus_code
,d.prm_det_note1			= b.ast_det_note1
,d.prm_det_varchar3			= b.ast_det_note2 
,d.prm_det_varchar1			= b.ast_det_varchar1
,d.prm_det_varchar2			= a.ast_mst_asset_code
,d.prm_det_varchar4			= a.ast_mst_perm_id
,d.prm_det_varchar5			= b.ast_det_mfg_cd
,d.prm_det_varchar6			= b.ast_det_modelno
,d.prm_det_varchar7			= b.ast_det_varchar2
,d.prm_det_varchar8			= b.ast_det_varchar22 
from prm_mst m	(nolock) 
join ast_mst a	(nolock) on m.prm_mst_assetno = a.ast_mst_asset_no
join prm_det d	(nolock)  on m.RowID = d.mst_RowID
join ast_det b	(nolock) on a.RowID = b.mst_RowID
and d.prm_det_customer_cd = b.ast_det_cus_code
 and year(m.prm_mst_lpm_date) = 2018
--and d.prm_det_chg_costcenter != a.ast_mst_cost_center
--44357
--583

--alter table prm_det alter column prm_det_varchar3 varchar(1000)
