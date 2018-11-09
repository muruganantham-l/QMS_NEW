
ALTER proc clinic_asset_migration_sp
@clinic_code_from varchar(40) = 'JHR734'
,@clinic_code_to varchar(40) = 'JHR723'
as
begin
set nocount ON

--create table clinic_asset_migration_log
--(
--benumber   varchar(40)
--,wr_number varchar(40)
--,wo_number varchar(40)
--,pm_number varchar(40)
--,clinic_code_from  varchar(40)
--,clinic_code_to  varchar(40)
--,created_by varchar(40)
--,created_date datetime
--)
 
insert clinic_asset_migration_log (benumber,created_by,created_date,clinic_code_from,clinic_code_to)
SELECT m.ast_mst_asset_no,'patch',getdate(),@clinic_code_from,@clinic_code_to
from ast_mst m join ast_det d on m.RowID = d.mst_RowID and d.ast_det_cus_code = @clinic_code_from--'SBH731'

update d set ast_det_cus_code = @clinic_code_to-- 'SBH731'
from ast_mst m join ast_det d on m.RowID = d.mst_RowID and d.ast_det_cus_code = @clinic_code_from--'SBH731'
 
  
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
AND M.cus_mst_customer_cd = @clinic_code_to--'SBH731'
join clinic_asset_migration_log l on l.benumber = a.ast_mst_asset_no
and l.clinic_code_from = @clinic_code_from
and l.clinic_code_to = @clinic_code_to


update a
SET ast_det_varchar1 = c.cus_mst_fob --clinic type
,ast_det_note1 = cus_mst_desc
,ast_det_note2 = cus_det_address1
,ast_det_varchar6 = cus_det_contact1
,ast_det_varchar7 = cus_det_contact2
,ast_det_varchar8 = cus_det_fax_phone
,ast_det_varchar23 = CONCAT(ast_mst_ast_lvl,'-',ast_mst_asset_code,'-',ast_mst_asset_locn)
  from --asset_batch8 b
  ast_mst m-- on m.ast_mst_asset_no = b.ast_mst_asset_no
join ast_det a on a.mst_RowID = m.RowID
join cus_mst c  
on c.cus_mst_customer_cd = a.ast_det_cus_code

join cus_det s on c.RowID = s.mst_RowID
--join clinic_mst v on v.BE_Number = m.ast_mst_asset_no
AND c.cus_mst_customer_cd = @clinic_code_to--'SBH731'
join clinic_asset_migration_log l on l.benumber = m.ast_mst_asset_no
and l.clinic_code_from = @clinic_code_from
and l.clinic_code_to = @clinic_code_to
 
 --test
 SELECT * from clinic_asset_migration_log where clinic_code_from = @clinic_code_from and clinic_code_to = @clinic_code_to
 
-- create table clinic_wo_migration_log
--( 
--wo_number varchar(40)
 
--,clinic_code_from  varchar(40)
--,clinic_code_to  varchar(40)
--,created_by varchar(40)
--,created_date datetime
--)


insert clinic_wo_migration_log (wo_number,created_by,created_date,clinic_code_from,clinic_code_to)
SELECT m.wko_mst_wo_no,'patch',getdate(),@clinic_code_from,@clinic_code_to
from wko_mst m join wko_det d on m.RowID = d.mst_RowID --and d.wko_det_customer_cd = @clinic_code_from--'SBH731'
join clinic_asset_migration_log l on l.benumber = m.wko_mst_assetno
and l.clinic_code_from = @clinic_code_from
and l.clinic_code_to = @clinic_code_to

update d set  d.wko_det_customer_cd = @clinic_code_to
from wko_mst m join wko_det d on m.RowID = d.mst_RowID --and d.wko_det_customer_cd = @clinic_code_from
join clinic_asset_migration_log l on l.benumber = m.wko_mst_assetno
and l.clinic_code_from = @clinic_code_from
and l.clinic_code_to = @clinic_code_to

--SELECT m.wko_mst_chg_costcenter,d.wko_det_note1 /*cus_mst_desc*/,d.wko_det_varchar3 /*cus_det_address1*/,d.wko_det_varchar1 /*c.cus_mst_fob*/
--,d.wko_det_varchar2 /*cus_mst_shipvia*/,d.wko_det_varchar4 /*cus_det_province*/

update m set wko_mst_chg_costcenter = c.cus_mst_seller
,m.wko_mst_asset_level = cus_det_state
,m.wko_mst_work_area = cus_det_email_id
,m.wko_mst_asset_location = cus_det_city

 from wko_mst m join wko_det d on m.RowID = d.mst_RowID 
 join cus_mst c on c.cus_mst_customer_cd = d.wko_det_customer_cd
 join cus_det cd on c.RowID = cd.mst_RowID
 join clinic_wo_migration_log t on t.wo_number = m.wko_mst_wo_no

 update d set wko_det_note1 = cus_mst_desc,wko_det_varchar3 = cus_det_address1,wko_det_varchar1 = cus_mst_fob,wko_det_varchar2 = cus_mst_shipvia
 ,wko_det_varchar4 = cus_det_province
 ,wko_det_chg_costcenter =  c.cus_mst_seller
  from wko_mst m join wko_det d on m.RowID = d.mst_RowID 
 join cus_mst c on 
c.cus_mst_customer_cd = d.wko_det_customer_cd
 join cus_det cd on c.RowID = cd.mst_RowID
 join clinic_wo_migration_log t on t.wo_number = m.wko_mst_wo_no

 --test
 select * from clinic_wo_migration_log where clinic_code_from = @clinic_code_from and clinic_code_to = @clinic_code_to
--  create table clinic_wr_migration_log
--( 
--wr_number varchar(40)
 
--,clinic_code_from  varchar(40)
--,clinic_code_to  varchar(40)
--,created_by varchar(40)
--,created_date datetime
--)


insert clinic_wr_migration_log (wr_number,created_by,created_date,clinic_code_from,clinic_code_to)
SELECT m.wkr_mst_wr_no,'patch',getdate(),@clinic_code_from,@clinic_code_to
from wkr_mst m join wkr_det d on m.RowID = d.mst_RowID --and d.wko_det_customer_cd = @clinic_code_from--'SBH731'
join clinic_asset_migration_log l on l.benumber = m.wkr_mst_assetno
and l.clinic_code_from = @clinic_code_from
and l.clinic_code_to = @clinic_code_to

update d set  d.wkr_det_cus_code = @clinic_code_to
from wkr_mst m join wkr_det d on m.RowID = d.mst_RowID --and d.wko_det_customer_cd = @clinic_code_from
join clinic_asset_migration_log l
 on l.benumber = m.wkr_mst_wr_no
and l.clinic_code_from = @clinic_code_from
and l.clinic_code_to = @clinic_code_to

--SELECT m.wko_mst_chg_costcenter,d.wko_det_note1 /*cus_mst_desc*/,d.wko_det_varchar3 /*cus_det_address1*/,d.wko_det_varchar1 /*c.cus_mst_fob*/
--,d.wko_det_varchar2 /*cus_mst_shipvia*/,d.wko_det_varchar4 /*cus_det_province*/

update m set m.wkr_mst_chg_costcenter = c.cus_mst_seller
,m.wkr_mst_location = cus_det_state
,m.wkr_mst_work_area = cus_det_email_id
,m.wkr_mst_assetlocn = cus_det_city

 from wkr_mst m join wkr_det d on m.RowID = d.mst_RowID 
 join cus_mst c on c.cus_mst_customer_cd = d.wkr_det_cus_code
 join cus_det cd on c.RowID = cd.mst_RowID
 join clinic_wr_migration_log t on t.wr_number = m.wkr_mst_wr_no
 
 update d set wkr_det_note1 = cus_mst_desc ,wkr_det_varchar1 = cus_mst_fob,wkr_det_varchar2 = cus_mst_shipvia
 ,wkr_det_varchar3 = cus_det_address1
 --,d. =  c.cus_mst_seller
 ,d.wkr_det_varchar4 = s.cus_det_province--zone  
  from wkr_mst m join wkr_det d on m.RowID = d.mst_RowID 
 join cus_mst c on c.cus_mst_customer_cd = d.wkr_det_cus_code
 join cus_det s on c.RowID = s.mst_RowID
 join clinic_wr_migration_log t on t.wr_number = m.wkr_mst_wr_no

 
 --test
 select * from clinic_wr_migration_log where clinic_code_from = @clinic_code_from and clinic_code_to = @clinic_code_to
 
--  create table clinic_prm_migration_log
--( 
--pm_number varchar(40)
 
--,clinic_code_from  varchar(40)
--,clinic_code_to  varchar(40)
--,created_by varchar(40)
--,created_date datetime
--)


insert clinic_prm_migration_log (pm_number,created_by,created_date,clinic_code_from,clinic_code_to)
SELECT m.prm_mst_pm_no,'patch',getdate(),@clinic_code_from,@clinic_code_to
from prm_mst m join prm_det d on m.RowID = d.mst_RowID --and d.wko_det_customer_cd = @clinic_code_from--'SBH731'
join clinic_asset_migration_log l on l.benumber = m.prm_mst_assetno
and l.clinic_code_from = @clinic_code_from
and l.clinic_code_to = @clinic_code_to

update d set  d.prm_det_customer_cd = @clinic_code_to
from prm_mst m join prm_det d on m.RowID = d.mst_RowID --and d.wko_det_customer_cd = @clinic_code_from
join 
clinic_asset_migration_log l on l.benumber = m.prm_mst_assetno
and l.clinic_code_from = @clinic_code_from
and l.clinic_code_to = @clinic_code_to

--SELECT m.wko_mst_chg_costcenter,d.wko_det_note1 /*cus_mst_desc*/,d.wko_det_varchar3 /*cus_det_address1*/,d.wko_det_varchar1 /*c.cus_mst_fob*/
--,d.wko_det_varchar2 /*cus_mst_shipvia*/,d.wko_det_varchar4 /*cus_det_province*/

--update m set prm_det_chg_costcenter = c.cus_mst_seller
--,m.wko_mst_asset_level = cus_det_state
--,m.wko_mst_work_area = cus_det_email_id
--,m.wko_mst_asset_location = cus_det_city

-- from prm_mst m join prm_det d on m.RowID = d.mst_RowID 
-- join cus_mst c on c.cus_mst_customer_cd = d.prm_det_customer_cd
-- join cus_det cd on c.RowID = cd.mst_RowID
-- join clinic_wr_migration_log t on t.pm_number = m.prm_mst_pm_no
 
 update d set prm_det_note1 = cus_mst_desc
 ,prm_det_varchar3 = cus_det_address1
 ,prm_det_varchar1 = cus_mst_fob
 ,prm_det_varchar2 = cus_mst_shipvia
 
 

 ,d.prm_det_varchar4 = s.cus_det_province--zone  

 ,prm_det_chg_costcenter =  c.cus_mst_seller
 ,prm_det_asset_level = cus_det_state
 ,prm_det_work_area = cus_det_email_id
 ,prm_det_varchar9 = s.cus_det_contact1
  from prm_mst m join prm_det d on m.RowID = d.mst_RowID 
 join cus_mst c on c.cus_mst_customer_cd = d.prm_det_customer_cd
 join cus_det s on c.RowID = s.mst_RowID
 join clinic_prm_migration_log t on t.pm_number = m.prm_mst_pm_no

 
 --test
 select * from clinic_prm_migration_log where clinic_code_from = @clinic_code_from and clinic_code_to = @clinic_code_to

 END
  

   




