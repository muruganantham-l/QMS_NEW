 /*
 note : batch end date hard coded please ask it for every batch before migrate
 */
ALTER proc asset_migration_sp
as
begin
set NOCOUNT ON

declare @sysdate	datetime = getdate()
       ,@user		varchar(30) = 'tomms'
	   ,@site_code  varchar(30) = 'QMS'
	   ,@date date = getdate()
	   
DECLARE @sql1 NVARCHAR(max) = ''
DECLARE @sql2 NVARCHAR(max) = ''
DECLARE @sql3 NVARCHAR(max) = ''

select @sql1 =   'select * into ast_mst from ast_mst'
select @sql2 =   'select * into ast_det  from ast_det'
select @sql3 =   'SELECT * into ast_aud  from ast_aud'

--EXEC(@sql1)
--EXEC(@sql2)
--EXEC(@sql3)

--select * into ast_mst_bak_2018_10_24 from ast_mst
--select * into ast_det_bak_2018_10_24   from ast_det
--SELECT * into ast_aud_bak_2018_10_24  from ast_aud

 delete from asset_migration_tmp where  ast_mst_asset_no = 'BE Number'
--need to handle supplier master
update asset_migration_tmp
SET
 ast_mst_asset_no			= replace(replace(replace(ast_mst_asset_no,char(9),''),char(10),''),char(13),'')
,ast_mst_asset_grpcode		= replace(replace(replace(ast_mst_asset_grpcode,char(9),''),char(10),''),char(13),'')
,ast_mst_asset_status		= replace(replace(replace(ast_mst_asset_status,char(9),''),char(10),''),char(13),'')
,ast_mst_safety_rqmts		= replace(replace(replace(ast_mst_safety_rqmts,char(9),''),char(10),''),char(13),'')
,ast_det_mfg_cd				= replace(replace(replace(ast_det_mfg_cd,char(9),''),char(10),''),char(13),'')
,ast_det_modelno			= replace(replace(replace(ast_det_modelno,char(9),''),char(10),''),char(13),'')
,ast_det_varchar2			= replace(replace(replace(ast_det_varchar2,char(9),''),char(10),''),char(13),'')
,ast_det_varchar4			= replace(replace(replace(ast_det_varchar4,char(9),''),char(10),''),char(13),'')
,ast_det_varchar9			= replace(replace(replace(ast_det_varchar9,char(9),''),char(10),''),char(13),'')
,ast_det_cus_code			= replace(replace(replace(ast_det_cus_code,char(9),''),char(10),''),char(13),'')
,ast_det_varchar15			= replace(replace(replace(ast_det_varchar15,char(9),''),char(10),''),char(13),'')
,ast_det_varchar24			= replace(replace(replace(ast_det_varchar24,char(9),''),char(10),''),char(13),'')
,ast_det_varchar21			= replace(replace(replace(ast_det_varchar21,char(9),''),char(10),''),char(13),'')
,ast_det_datetime1			= replace(replace(replace(ast_det_datetime1,char(9),''),char(10),''),char(13),'')
,ast_det_warranty_date		= replace(replace(replace(ast_det_warranty_date,char(9),''),char(10),''),char(13),'')
,ast_det_datetime3			= replace(replace(replace(ast_det_datetime3,char(9),''),char(10),''),char(13),'')
,ast_det_datetime4			= replace(replace(replace(ast_det_datetime4,char(9),''),char(10),''),char(13),'')
,ast_det_datetime5			= replace(replace(replace(ast_det_datetime5,char(9),''),char(10),''),char(13),'')
,ast_det_datetime6			= replace(replace(replace(ast_det_datetime6,char(9),''),char(10),''),char(13),'')
,ast_det_datetime7			= replace(replace(replace(ast_det_datetime7,char(9),''),char(10),''),char(13),'')
,ast_det_datetime8			= replace(replace(replace(ast_det_datetime8,char(9),''),char(10),''),char(13),'')
,ast_det_varchar22			= replace(replace(replace(ast_det_varchar22,char(9),''),char(10),''),char(13),'')
,ast_det_purchase_date		= replace(replace(replace(ast_det_purchase_date,char(9),''),char(10),''),char(13),'')
,ast_det_varchar25			= replace(replace(replace(ast_det_varchar25,char(9),''),char(10),''),char(13),'')
,ast_det_varchar5			= replace(replace(replace(ast_det_varchar5,char(9),''),char(10),''),char(13),'')
,ast_det_varchar16			= replace(replace(replace(ast_det_varchar16,char(9),''),char(10),''),char(13),'')

update asset_migration_tmp
set  ast_det_varchar2 = REPLACE(ast_det_varchar2,'''','')
 

 --update asset_migration_tmp set error_flag = 'N' where ast_mst_asset_no= 'SBNREE006' 
update t
SET    error_flag = 'W'
       ,error_desc = 'Asset Already Exists'
from   asset_migration_tmp t (NOLOCK)
JOIN   ast_mst m (NOLOCK)
on     t.ast_mst_asset_no = m.ast_mst_asset_no 
where  error_flag = 'N'

insert ast_mst
(
site_cd
,ast_mst_asset_no
,audit_user
,audit_date
,ast_mst_create_by
,ast_mst_create_date
)
SELECT @site_code,ast_mst_asset_no,@user,@sysdate,'Patch', @sysdate
from   asset_migration_tmp
where  error_flag = 'N'
--and ast_mst_asset_no= 'SBNREE006' 
 

UPDATE asset_migration_tmp
set     ast_det_varchar15 = case ast_det_varchar15 when    'PBE' then 'Purchase Biomedical' 
													 when 'NBE' then 'New Biomedical' else ast_det_varchar15 end -- Ownership:
where error_flag = 'N' 

update a
set a.ast_mst_asset_grpcode = t.ast_mst_asset_grpcode --'BE Code'
   ,a.ast_mst_asset_status  = t.ast_mst_asset_status  --'BE Conditional Status'
   ,a.ast_mst_safety_rqmts  = case ast_det_varchar15 when 'Purchase Biomedical' then 'V5 : Purchase Biomedical' 
													 when 'New Biomedical'      then 'V4 : New Biomedical' 
													 else null end   --variation order
	,a.ast_mst_parent_flag = 0
from ast_mst a 
join asset_migration_tmp t
on a.ast_mst_asset_no = t.ast_mst_asset_no
and t.error_flag = 'N'


update  t
SET		t.error_flag  = 'Y'
	    ,t.error_desc = 'ast_mst_asset_type (BE group not found)'
from	ast_grp g (nolock)
left join asset_migration_tmp t 
on g.ast_grp_grp_cd =  t.ast_mst_asset_grpcode
where t.ast_mst_asset_grpcode is NULL
and t.error_flag = 'N'

update A
set ast_mst_asset_shortdesc	= ast_grp_general_name		--		'BE General Name'
,ast_mst_asset_type			= ast_grp_group				--		'BE Group'
,ast_mst_cri_factor			= ast_grp_cri_factor 		--		'BE Critical Factor'
,ast_mst_wrk_grp			= ast_grp_classification	--		Work Group:
,ast_mst_asset_longdesc		= ast_grp_desc				--		BE Category:
,ast_mst_print_count		= 0							--		bar code print count
from ast_mst a
join ast_grp g (NOLOCK)
on a.ast_mst_asset_grpcode =g.ast_grp_grp_cd
join  asset_migration_tmp b
on a.ast_mst_asset_no = b.ast_mst_asset_no
and b.error_flag = 'N'
  

update  t
SET		t.error_flag  = 'Y'
	    ,t.error_desc = 'ast_det_cus_code (Clinic code not found)'
from	cus_mst g (nolock)
left join asset_migration_tmp t 
on g.cus_mst_customer_cd =  t.ast_det_cus_code
where t.ast_det_cus_code is NULL
and   t.error_flag = 'N'

update asset_migration_tmp
set
ast_det_warranty_date = dateadd(mm,12,ast_det_datetime1)-1 -- warrenty end

--,ast_det_datetime5 = dateadd(dd,-1,ast_det_datetime1) --Batch End Date: 
,ast_det_datetime7 =  DATEADD(DAY,-DAY(dateadd(mm,1,ast_det_datetime6))+1, dateadd(mm,1,ast_det_datetime6))
--concat(year(ast_det_datetime6),'-',month(ast_det_datetime6)+1,'-','01')	-- Acceptance Date:
,ast_det_datetime8 = ast_det_datetime6 -- Installation Date:
,ast_det_varchar22 = case ast_det_varchar15 when 'Purchase Biomedical' then 'PUR' 
													 when 'New Biomedical'      then 'NEW' 
													 else null end ---- Ramco Flag Invoice:
where error_flag = 'N'
  
  --30 nov 2018

  --first of the following t&c month - rental start

update asset_migration_tmp
set
ast_det_datetime3	  = --cast(concat(year(ast_det_datetime6),'-',month(ast_det_datetime6)+1,'-','01') as DATETIME) 	-- Rental Start:
 DATEADD(DAY,-DAY(dateadd(mm,1,ast_det_datetime6))+1, dateadd(mm,1,ast_det_datetime6))
,ast_det_datetime4	  = dateadd(mm,96, DATEADD(DAY,-DAY(dateadd(mm,1,ast_det_datetime6))+1, dateadd(mm,1,ast_det_datetime6))-1)	-- Rental End:
--dateadd(mm,96,cast(concat(year(ast_det_datetime6),'-',month(ast_det_datetime6)+1,'-','01')	as DATETIME)-1)	-- Rental End:
where error_flag = 'N'
and ast_det_varchar15 = 'New Biomedical'

update asset_migration_tmp
set
ast_det_datetime19  = DATEADD(DAY,-DAY(dateadd(mm,1,ast_det_datetime6))+1, dateadd(mm,1,ast_det_datetime6))
-- cast(concat(year(ast_det_datetime6),'-',month(ast_det_datetime6)+1,'-','01') as DATETIME) 	-- Rental Start:
,ast_det_datetime20  =dateadd(mm,96, DATEADD(DAY,-DAY(dateadd(mm,1,ast_det_datetime6))+1, dateadd(mm,1,ast_det_datetime6))-1)	-- Rental End:
-- dateadd(mm,96,cast(concat(year(ast_det_datetime6),'-',month(ast_det_datetime6)+1,'-','01')	as DATETIME)-1)	-- Rental End:
where error_flag = 'N'
--30 nov - batch
--1 dec --accep date

update asset_migration_tmp
set ast_det_datetime5 = '2018-05-31'-- '2018-11-30' -- batch end for batch 9
where error_flag = 'N'

update asset_migration_tmp
set ast_det_datetime7 /*accep date*/ =  DATEADD(DAY,-DAY(dateadd(mm,1,ast_det_datetime5))+1, dateadd(mm,1,ast_det_datetime5))
--'2018-12-01'-- next month first date for batch end

,ast_det_datetime19  = DATEADD(DAY,-DAY(dateadd(mm,1,ast_det_datetime5))+1, dateadd(mm,1,ast_det_datetime5))
-- cast(concat(year(ast_det_datetime6),'-',month(ast_det_datetime6)+1,'-','01') as DATETIME) 	-- Rental Start:
,ast_det_datetime20  =dateadd(mm,96, DATEADD(DAY,-DAY(dateadd(mm,1,ast_det_datetime5))+1, dateadd(mm,1,ast_det_datetime5))-1)	-- Rental End:

,ast_det_datetime3	  = --cast(concat(year(ast_det_datetime6),'-',month(ast_det_datetime6)+1,'-','01') as DATETIME) 	-- Rental Start:
 DATEADD(DAY,-DAY(dateadd(mm,1,ast_det_datetime5))+1, dateadd(mm,1,ast_det_datetime5))
,ast_det_datetime4	  = dateadd(mm,96, DATEADD(DAY,-DAY(dateadd(mm,1,ast_det_datetime5))+1, dateadd(mm,1,ast_det_datetime5))-1)	-- Rental End:
where error_flag = 'N'
and  ast_det_datetime6 /*T&C date*/ <= ast_det_datetime5 -- batch end
--1292
--1925
--SELECT * into asset_migration_tmp_bak_2019_01_07 from asset_migration_tmp

insert ast_det
(
 ast_det_mfg_cd			
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
,ast_det_datetime2
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
,mst_RowID
,site_cd
,audit_user
,audit_date
)
SELECT
 ast_det_mfg_cd			-- Manufacturer:
,ast_det_modelno		-- model	
,ast_det_varchar2		-- Serial Number:
,ast_det_varchar4		-- BE Status:	
,ast_det_varchar9		-- Region:	
,ast_det_cus_code		-- Clinic Code:	
,ast_det_varchar15		-- Ownership:
,ast_det_varchar16		-- Supplier Name:
,ast_det_varchar5		-- DRN NO :
,ast_det_varchar24		-- Supplier Code: 
,ast_det_varchar25		-- Supplier email:
,ast_det_varchar21		-- BATCH	
,ast_det_datetime1		-- Warranty Start:
,ast_det_warranty_date	-- Warranty Expiry:
,ast_det_warranty_date  -- warrenty end
,ast_det_datetime3		-- Rental Start:
,ast_det_datetime4		-- Rental End:
,ast_det_datetime5		-- Batch End Date: 
,ast_det_datetime6		-- T&&C Date:
,ast_det_datetime7		-- Acceptance Date:
,ast_det_datetime8		-- Installation Date:
,ast_det_varchar22		-- Ramco Flag Invoice: -- not given in the file
,ast_det_purchase_date	-- Purchase Date:
,ast_det_datetime19		-- Rental Start:
,ast_det_datetime20		-- Rental End:
,m.RowID
,m.site_cd
,m.audit_user
,m.audit_date
from asset_migration_tmp t
join ast_mst m 
on m.ast_mst_asset_no = t.ast_mst_asset_no
and t.error_flag = 'N'



update a
set 
ast_mst_cost_center = m.cus_mst_seller-- cost centre
,ast_mst_work_area = s.cus_det_email_id--circle
,ast_mst_asset_code = m.cus_mst_shipvia--Clinic Category
,ast_mst_perm_id = s.cus_det_province--zone  
,ast_mst_ast_lvl = s.cus_det_state -- state
,ast_mst_asset_locn  = s.cus_det_city--district
from ast_mst a
join asset_migration_tmp b on a.ast_mst_asset_no = b.ast_mst_asset_no and b.error_flag = 'N'
join ast_det d  (NOLOCK) on a.rowid = d.mst_RowID
join cus_mst m  (NOLOCK) on m.cus_mst_customer_cd = d.ast_det_cus_code
join cus_det s  (NOLOCK) on m.RowID = s.mst_RowID

update b
SET ast_det_varchar9 = case when ast_mst_ast_lvl in ('SABAH','SARAWAK','WILAYAH PERSEKUTUAN LABUAN') then 'EM' else 'WM' END--region
from ast_mst a
join asset_migration_tmp b on a.ast_mst_asset_no = b.ast_mst_asset_no and b.error_flag = 'N'
 



update a
set 
ast_det_depr_term=g.ast_grp_est_srv_life -- Expected Life (Year):
,ast_det_asset_cost = g.ast_grp_purchase_cost -- Purchase Cost
,ast_det_numeric9=g.ast_grp_rental_value
,ast_det_varchar12 = g.ast_grp_classification--BE Classification:
,ast_det_varchar10 =g.ast_grp_maintenance_type   --SM Type:
,ast_det_varchar11 =g.ast_grp_maint_freq   --PPM Frequency 
,ast_det_numeric2 =case when b.ast_det_varchar9 = 'EM' THEN ast_grp_maintenance_rate_east WHEN B.ast_det_varchar9= 'WM' THEN G.ast_grp_maintenance_rate_west ELSE 0 END-- Main.Rate(%)
,ast_det_numeric1 =case when b.ast_det_varchar9 = 'EM' THEN ast_grp_maintenance_value_east WHEN B.
ast_det_varchar9= 'WM' THEN G.ast_grp_maintenance_value ELSE 0 END * 12--Main.Rev(Year):  
,ast_det_numeric8=case when b.ast_det_varchar9 = 'EM' THEN ast_grp_maintenance_value_east WHEN B.ast_det_varchar9= 'WM' THEN G.ast_grp_maintenance_value ELSE 0 END--Main.Rev(Monthly) 
--,ast_det_varchar23 =  CONCAT(ast_mst_ast_lvl,'-',ast_mst_asset_code,'-',ast_mst_asset_locn)--concat(left(ast_mst_cost_center,3),right(ast_mst_cost_center,6)) --Ramco Invoice:
,a.ast_det_varchar9 = b.ast_det_varchar9
,a.ast_det_varchar15 = b.ast_det_varchar15
from asset_migration_tmp b
join ast_mst m on m.
ast_mst_asset_no = b.ast_mst_asset_no
join ast_det a on a.mst_RowID = m.RowID
join ast_grp g on b.ast_mst_asset_grpcode =g.ast_grp_grp_cd
and  b.error_flag = 'N'


 
update a
set    ast_det_varchar23 = concat(s.state_code,'-',left(ast_mst_asset_code,1),'-',district_code)
from asset_migration_tmp b
join ast_mst m on m.ast_mst_asset_no = b.ast_mst_asset_no
join ast_det a on a.mst_RowID = m.RowID
join state_desc_qms s (NOLOCK) on s.state_desc = ast_mst_ast_lvl
join district_desc_qms d on d.district_desc = ast_mst_asset_locn
 

--alter table asset_migration_tmp drop column  ast_det_varchar23 varchar(300)

update a
SET ast_det_varchar1 = c.cus_mst_fob -- Clinic Type:
,ast_det_note1 = cus_mst_desc -- Clinic Name:
,ast_det_note2 = cus_det_address1 -- Clinic Address:
,ast_det_varchar6 = cus_det_contact1 -- Clinic Contact No 1:
,ast_det_varchar7 = cus_det_contact2 --Clinic Contact No 2:
,ast_det_varchar8 = cus_det_fax_phone --Clinic Fax No:
from  asset_migration_tmp b
join  ast_mst m (nolock)  on m.ast_mst_asset_no = b.ast_mst_asset_no
join  ast_det a (nolock)  on a.mst_RowID = m.RowID
join  cus_mst c (nolock
)  on c.cus_mst_customer_cd = a.ast_det_cus_code
join  cus_det s (nolock)  on c.RowID = s.mst_RowID
and   b.error_flag = 'N'


insert ast_aud(site_cd,mst_RowID,ast_aud_asset_no,ast_aud_status,ast_aud_originator,ast_aud_start_date,ast_aud_end_date,ast_aud_duration,audit_user,audit_date)
SELECT m.site_cd,m.RowID,m.ast_mst_asset_no,m.ast_mst_asset_status,m.audit_user,m.audit_date,NULL,0,m.audit_user,m.audit_date
from asset_migration_tmp a join ast_mst m on a.ast_mst_asset_no = m.ast_mst_asset_no
and a.error_flag = 'N'


--SELECT * from ast_mst m join ast_det d on m.RowID = d.mst_rowid where ast_mst_asset_no= 'SBNREE006' 
-- SELECT * from ast_aud where ast_aud_asset_no = 'SBNREE006'
 --select * from asset_migration_tmp where ast_mst_asset_no = 'SBNREE006'
--SELECT * from asset_migration_tmp where ast_mst_asset_no= 'SBNREE006'
--delete d from ast_mst m join ast_det d on m.RowID = d.mst_RowID join asset_migration_tmp a on a.ast_mst_asset_no = m.ast_mst_asset_no and a.error_flag= 'Y'

--delete m from ast_mst m  join asset_migration_tmp a on a.ast_mst_asset_no = m.ast_mst_asset_no and a.error_flag= 'Y'


set nocount OFF
end


--delete from ast_det where mst_rowid = 577544 and ast_det_varchar15 is NULL



--delete d from ast_mst m join ast_det d on m.RowID = d.mst_rowid where ast_mst_asset_no= 'SBNREE006' 
--delete ast_mst where ast_mst_asset_no= 'SBNREE006' 
--delete ast_aud where ast_aud_asset_no = 'SBNREE006'

