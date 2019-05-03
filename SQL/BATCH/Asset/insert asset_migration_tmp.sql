--delete asset_migration_tmp

insert asset_migration_tmp
(
ast_mst_asset_no
,ast_mst_asset_grpcode
,ast_mst_asset_status
,ast_mst_safety_rqmts
,ast_det_mfg_cd
,ast_det_modelno
,ast_det_varchar2
,ast_det_varchar4
,ast_det_varchar9
,ast_det_cus_code
,ast_det_varchar15
,ast_det_varchar16
,ast_det_varchar5
,ast_det_varchar24
,ast_det_varchar25
,ast_det_varchar21
,ast_det_datetime1
,ast_det_warranty_date
,ast_det_datetime3
,ast_det_datetime4
,ast_det_datetime5
,ast_det_datetime6
,ast_det_datetime7
,ast_det_datetime8
,ast_det_varchar22
,ast_det_purchase_date
,ast_det_datetime19
,ast_det_datetime20
,error_flag
,error_desc
,ast_det_varchar13

)

SELECT
ast_mst_asset_no
,ast_mst_asset_grpcode
,ast_mst_asset_status
,ast_mst_safety_rqmts
,ast_det_mfg_cd
,ast_det_modelno
,ast_det_varchar2
,ast_det_varchar4
,null ast_det_varchar9
,ast_det_cus_code
,ast_det_varchar15
,ast_det_varchar16
,ast_det_varchar5
,ast_det_varchar24
,ast_det_varchar25
,ast_det_varchar21
,ast_det_datetime1
,isnull(ast_det_warranty_date ,ast_det_warranty_date)
, ast_det_datetime3
,dateadd(mm,96,ast_det_datetime3)-1 ast_det_datetime4
,null ast_det_datetime5
,ast_det_datetime6
,null ast_det_datetime7
,null ast_det_datetime8
,null ast_det_varchar22
,  ast_det_purchase_date
,null ast_det_datetime19
,null ast_det_datetime20
,'N' error_flag
,null error_desc
,ast_det_varchar13

from asset_migration_2019_04_23
 where ast_mst_asset_no <> 'BE Number'

 --drop table asset_migration_2019_04_23

 SELECT * from asset_migration_2019_04_23 where ast_mst_asset_no = 'PNNCHD026'

update t 
set ast_mst_asset_grpcode = g.ast_grp_grp_cd
from asset_migration_tmp t
join ast_grp g on g.ast_grp_desc = ast_mst_asset_grpcode
and ast_det_varchar15
 = 'New Biomedical'
 and ast_grp_grp_cd like '%N'

 
update t 
set ast_mst_asset_grpcode = g.ast_grp_grp_cd
from asset_migration_tmp t
join ast_grp g on g.ast_grp_desc = ast_mst_asset_grpcode
and ast_det_varchar15
 = 'Purchase Biomedical'
 and ast_grp_grp_cd like '%P'

 
update t 
set ast_mst_asset_grpcode = g.ast_grp_grp_cd
from asset_migration_tmp t
join ast_grp g on g.ast_grp_desc = ast_mst_asset_grpcode
and ast_det_varchar15
 = 'Existing'
 and (ast_grp_grp_cd not like '%P' and  ast_grp_grp_cd not like '%N' )
 --and ast_mst_asset_grpcode like '%Analyzers, Laboratory, Hematology, Cell Counting, Automated ( High)%'

 SELECT ast_mst_asset_grpcode
 from   asset_migration_tmp
 except 
 select ast_grp_grp_cd from ast_grp
  

 select ast_grp_grp_cd,* from ast_grp where ast_grp_desc like '%Scanning%Systems%Ultrasonic%General%Purpose%'
update t set ast_mst_asset_grpcode = 'ME-030N' from asset_migration_tmp t 
 where ast_mst_asset_grpcode like '%Scanning%Systems%Ultrasonic%General%Purpose%(Medium)%'
 --Freezers, Laboratory Vaccine (Electrical)
 and ast_det_varchar15
='Existing'

 --New Biomedical -- Package Sealers

 --16-412
  select ast_grp_grp_cd,* from ast_grp where --ast_grp_grp_cd = '15-786n'--
   ast_grp_desc like '%Scanning%Systems%Ultrasonic%General%Purpose%(Medium)%'

   SELECT ast_det_datetime3,ast_det_datetime4, * from asset_migration_tmp where ast_det_varchar15
 = 'Purchase Biomedical'