--SELECT ast_mst_asset_status

--from ast_mst
--drop table asset_batch8
--SELECT * from asset_batch8
begin tran
insert ast_mst
(
 
ast_mst_asset_no
,ast_mst_asset_grpcode
,ast_mst_asset_longdesc
,ast_mst_asset_status

--Supplier Address
--Supplier Contact Person

,ast_mst_assigned_to

,ast_mst_perm_id
,ast_mst_safety_rqmts
,ast_mst_ast_lvl
,ast_mst_asset_locn
--Delivery date and time

--Delivery Status


,site_cd
,audit_user
,audit_date
,ast_mst_parent_flag	
,ast_mst_auto_no

--from master
,ast_mst_create_by
,ast_mst_create_date
,ast_mst_print_count

) 
SELECT 
ast_mst_asset_no
,ast_mst_asset_grpcode

,ast_mst_asset_longdesc
,ast_mst_asset_status

--Supplier Address
--Supplier Contact Person

,ast_mst_assigned_to

,ast_mst_perm_id
,ast_mst_safety_rqmts
,ast_mst_ast_lvl
,ast_mst_asset_locn
--Delivery date and time
,'QMS'
,'Tomms'
,GETDATE()
,0
,0 
 
 
 


,'patch'
,getdate()
,0

from  asset_batch8 b
--join ast_grp g 


--on b.ast_mst_asset_grpcode =g.ast_grp_grp_cd

--join cus_mst m  
--on m.cus_mst_customer_cd = b.ast_det_cus_code
--join cus_det s on m.RowID = s.mst_RowID

--where b.ast_mst_asset_no not in ( 'SLNVIB009','SBPBAD009')
--25
 
update A


set ast_mst_asset_shortdesc	= ast_grp_general_name							-- 'BE General Name'
,ast_mst_asset_type			=  		ast_grp_group					--		'BE Group'
,ast_mst_cri_factor			= ast_grp_cri_factor 								--		 'BE Critical Factor'
,ast_mst_wrk_grp = ast_grp_classification
from ast_mst a
join ast_grp g 
on a.ast_mst_asset_grpcode =g.ast_grp_grp_cd
join  asset_batch8 b
on a.ast_mst_asset_no = b.ast_mst_asset_no



update a
set 
ast_mst_cost_center = m.cus_mst_seller
,ast_mst_work_area = s.cus_det_email_id
,ast_mst_asset_code = m.cus_mst_shipvia
,ast_mst_perm_id = s.cus_det_province--zone  
,ast_mst_ast_lvl = s.cus_det_state -- state
--,ast_mst_work_area = s.cus_det_email_id--circle
,ast_mst_asset_locn  = s.cus_det_city--district

from ast_mst a
--join  asset_batch8 b
--on a.ast_mst_asset_no = b.ast_mst_asset_no
join ast_det d on a.rowid = d.mst_RowID
join cus_mst m  
on m.cus_mst_customer_cd = d.ast_det_cus_code

join cus_det s on m.RowID = s.mst_RowID
AND M.cus_mst_customer_cd = 'WPL006'
--join clinic_mst v on v.BE_Number = a.ast_mst_asset_no
/*
and ast_mst_asset_no in (
'SLNFRV038'
,'SLNFRV041'
,'PRPOTO257'
,'SWPSTN009'
,'SWPSTN010'
,'SWPLID023'
)

*/
 
 
insert ast_det
(
ast_det_varchar4
,ast_det_varchar9
,ast_det_varchar22
,ast_det_varchar15
,ast_det_varchar5
,ast_det_varchar24
,ast_det_varchar16
,ast_det_varchar25
,ast_det_mfg_cd
,ast_det_modelno
,ast_det_cus_code
,ast_det_note1
,ast_det_note2
,ast_det_varchar21
,ast_det_datetime6
,ast_det_varchar2
,ast_det_datetime8
,ast_det_purchase_date
,site_cd

,audit_user
,audit_date
,mst_RowID

,ast_det_datetime1--warranty start
,ast_det_warranty_date--'Warranty Expiry'
,ast_det_datetime3-- 'Rental Start'
,ast_det_datetime4--'Rental End'
,ast_det_datetime19
,ast_det_datetime20

,ast_det_datetime5--batch end date



,ast_det_datetime7 --acceptance date
)
SELECT
ast_det_varchar4
,ast_det_varchar9
,ast_det_varchar22
,ast_det_varchar15
,ast_det_varchar5
,ast_det_varchar24
,ast_det_varchar16
,ast_det_varchar25
,ast_det_mfg_cd
,ast_det_modelno
,ast_det_cus_code
,ast_det_note1
,ast_det_note2
,ast_det_varchar21
,ast_det_datetime6
,ast_det_varchar2
,ast_det_datetime8
,ast_det_purchase_date
,'QMS'
,'Tomms'
,GETDATE()
,m.RowID




,'2018-09-01'--warranty start
,'2019-08-31'--warrenty end 
,'2018-09-01'--rental start
,'2026-08-31'--rental end
,'2018-09-01'--rental start--,ast_det_datetime19
,'2026-08-31'--rental end--ast_det_datetime20

,'2018-08-31'--batch end date



,'2018-09-01'
from  asset_batch8 b
join ast_mst m on m.ast_mst_asset_no = b.ast_mst_asset_no

--join ast_grp g on b.ast_mst_asset_grpcode =g.ast_grp_grp_cd
--and len(ast_det_mfg_cd ) < 25 = 


--where b.ast_mst_asset_no not in ( 'SLNVIB009','SBPBAD009')

update a
set 
ast_det_depr_term=g.ast_grp_est_srv_life
,ast_det_asset_cost = g.ast_grp_purchase_cost
,ast_det_numeric9=g.ast_grp_rental_value
,ast_det_varchar12 = g.ast_grp_classification
,ast_det_varchar10 =g.ast_grp_maintenance_type   --sm type
,ast_det_varchar11 =g.ast_grp_maint_freq   --main freq
,ast_det_numeric2 =case when b.ast_det_varchar9 = 'EM' THEN ast_grp_maintenance_rate_east WHEN B.ast_det_varchar9= 'WM' THEN G.ast_grp_maintenance_rate_west ELSE 0 END-- maintenance rate
,ast_det_numeric1 =case when b.ast_det_varchar9 = 'EM' THEN ast_grp_maintenance_value_east WHEN B.ast_det_varchar9= 'WM' THEN G.ast_grp_maintenance_value ELSE 0 END * 12--maintenance rev yearly
,ast_det_numeric8=case when b.ast_det_varchar9 = 'EM' THEN ast_grp_maintenance_value_east WHEN B.ast_det_varchar9= 'WM' THEN G.ast_grp_maintenance_value ELSE 0 END--maintenance rev monthly -- maintenance rev monthly

from 
  asset_batch8 b
join ast_mst m on m.ast_mst_asset_no = b.ast_mst_asset_no
join ast_det a on a.mst_RowID = m.RowID
join ast_grp g on b.ast_mst_asset_grpcode =g.ast_grp_grp_cd



update a
SET ast_det_varchar1 = c.cus_mst_fob --clinic type
,ast_det_note1 = cus_mst_desc
,ast_det_note2 = cus_det_address1
,ast_det_varchar6 = cus_det_contact1
,ast_det_varchar7 = cus_det_contact2
,ast_det_varchar8 = cus_det_fax_phone
  from --asset_batch8 b
  ast_mst m-- on m.ast_mst_asset_no = b.ast_mst_asset_no
join ast_det a on a.mst_RowID = m.RowID
join cus_mst c  
on c.cus_mst_customer_cd = a.ast_det_cus_code

join cus_det s on c.RowID = s.mst_RowID
--join clinic_mst v on v.BE_Number = m.ast_mst_asset_no
AND c.cus_mst_customer_cd = 'WPL006'
--and m.ast_mst_asset_no in (
--'SLNFRV038'
--,'SLNFRV041'
--,'PRPOTO257'
--,'SWPSTN009'
--,'SWPSTN010'
--,'SWPLID023'
--)

--and b.ast_mst_asset_no in (
--'swplid021'
--,'swplid022'
--,'swplid024'
--,'swplid027'
--)
 COMMIT 
 --SELECT max(len(ast_det_mfg_cd )) from  asset_batch8 
 --SELECT   len(ast_det_mfg_cd ) ,  left(ast_det_mfg_cd,25) ,ast_det_varchar24,ast_det_mfg_cd from asset_batch8 where  len(ast_det_mfg_cd ) > 25
 --7
 --309
 --

 --select ast_det_varchar9,ast_mst_asset_grpcode,* from asset_batch8 where ast_mst_asset_no = 'SBPBAD009'
 ----EM -- 99-001P

 --SELECT * from ast_grp where ast_grp_grp_cd = '99-001P'
  

--alter table ast_det  
--alter column ast_det_mfg_cd varchar(50)


--SELECT ast_grp_maintenance_value_east ,ast_grp_maintenance_value   from ast_grp where ast_grp_grp_cd = '15-045'


--SELECT ast_mst_asset_status, * from ast_mst a join ast_det d on a.RowID = d.mst_RowID where ast_mst_asset_no = 'SBPBAD009'


--SELECT ast_mst_asset_status,* from ast_mst a join ast_det d on a.RowID = d.mst_RowID where   ast_det_varchar21 = 'batch4'

--SELECT  ast_mst_asset_status,* from ast_mst a join ast_det d on a.RowID = d.mst_RowID where   ast_det_varchar21= 'BATCH 4'


 
-- delete from   ast_mst where ast_mst_asset_no = 'SBPBAD009'
-- delete from ast_det where mst_RowID = '377331'

--SELECT ast_det_datetime6
----ast_det_varchar10,	ast_det_varchar11,

--from asset_batch8

--1.	Taxable (  )
--2.	Purchase order no – ()
--3.	ramco pkd/ppd invoice -- 
--4.	TE Requirement:-- 
--5.	 DLP Expiry Date -- 


--SELECT
----ast_det_taxable
----ast_det_varchar20
----ast_det_varchar23
----ast_det_varchar26
--ast_det_datetime10
--from asset_batch8