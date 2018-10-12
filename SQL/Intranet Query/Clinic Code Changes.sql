--Drop  table clinic_code_update_table
--go
--Create table clinic_code_update_table
--(asset_number varchar(100),
--BE_Category varchar(300),
--newcliniccode varchar(100),
--oldcliniccode varchar(100),
--state varchar(100),
--status varchar(100) ,
--updated varchar(3))
--go

--SBH317-P-PPG

--update ast_mst
--set ast_mst_cost_center= 'SBH317-P-PPG',audit_user = 'Tomms' ,audit_date = getdate() 
--from
--		ast_mst (nolock) ,
--		ast_det (nolock)
--WHERE ast_mst.rowid = ast_det.mst_rowid
--and ast_mst.site_cd = ast_det.site_cd
--AND ast_mst.site_cd = 'QMS'
--AND ast_det_cus_code = 'SBH317'


Declare @audituser			varchar(100) = 'tomms'
Declare @auditdate			datetime = getdate()
Declare @newcliniccode		varchar(100) 
Declare @oldcliniccode		varchar(100) 
Declare @status				varchar(100)
Declare @state				varchar(100)
Declare @assetnumber		varchar(100)
Declare @mst_rowid			int 

Declare @costcenter			varchar(100),
		@clinicname			varchar(500),
		@cliniccategory		varchar(100),
		@clinictype			varchar(100),
		@clinicaddress		varchar(1000),
		@cliniccontact		varchar(100),
		@cliniclocation		varchar(200),
		@clinicState		varchar(100),
		@cliniczone			varchar(100),
		@cliniccircle		varchar(100),
		@ramco_Cost			varchar(100)

Declare clinic_cursor cursor for
select asset_number,
newcliniccode,
oldcliniccode,
status,
state
from clinic_code_update_table (nolock)
where updated = 'No'
--and asset_number ='PRK003823'

open clinic_cursor
Fetch Next from clinic_cursor into 
@assetnumber ,@newcliniccode,@oldcliniccode,@status,@state

WHILE @@FETCH_STATUS = 0   
BEGIN 

select  
@costcenter = cus_mst_seller , 
@clinictype = cus_mst_fob ,
@cliniccategory = cus_mst_shipvia ,
@clinicname = replace(replace(cus_mst_desc,char(13),''),char(10),'') ,
@clinicaddress = replace(replace(cus_det_address1,char(13),''),char(10),''),
@cliniccontact = cus_det_contact1 ,
@cliniclocation = cus_det_city ,
@clinicState = cus_det_state ,
@cliniczone = cus_det_province ,
@cliniccircle = cus_det_email_id,
@ramco_Cost  = cus_det_varchar2
from
cus_mst (nolock) ,
cus_det (nolock)
where mst_RowID = cus_mst.RowID
and cus_mst_customer_cd = @newcliniccode

/* Update in Asset matser Screen*/

UPDATE ast_mst
SET ast_mst_work_area = @cliniccircle ,
ast_mst_cost_center = @costcenter ,
ast_mst_asset_locn = @cliniclocation ,
ast_mst_perm_id = @cliniczone ,
ast_mst_asset_code = @cliniccategory,
audit_user = @audituser, 
audit_date = @auditdate 
--,ast_mst_ast_lvl = 
WHERE ast_mst_asset_no = @assetnumber
AND site_cd = 'QMS'

UPDATE ast_det
SET 
ast_det_note1 = @clinicname,
ast_det_note2 = @clinicaddress ,
ast_det_varchar1 = @clinictype ,
ast_det_cus_code = @newcliniccode,
ast_det_varchar23 = @ramco_Cost,
audit_user = @audituser, 
audit_date = @auditdate 
from	ast_mst (nolock) ,
		ast_det (nolock)
WHERE ast_mst.rowid = ast_det.mst_rowid
and ast_mst.site_cd = ast_det.site_cd
AND ast_mst.site_cd = 'QMS'
and ast_mst_asset_no = @assetnumber
--and ast_det_cus_code = @oldcliniccode

Declare @batchid  int

Select 
@batchid = max([batch_no])
from cf_audit_column (nolock)

insert into cf_audit_column
([site_cd],[batch_no],[option_name],[table_name],[key_column],[key_value],[update_column],[new_value],[old_value],[audit_user],[audit_date]) Values ('QMS',@batchid+1,'Asset Register','ast_mst','ast_mst_asset_no',@assetnumber,'ast_det_cus_code',@newcliniccode,@oldcliniccode,'Tomms',getdate())
--297480


/* Update in Work Order matser Screen*/
/*
UPDATE wko_mst
SET wko_mst_work_area  = @cliniccircle ,
wko_mst_chg_costcenter = @costcenter ,
wko_mst_asset_location  = @cliniclocation ,
wko_mst_ast_cod  = @cliniccategory,
audit_user = @audituser, 
audit_date = @auditdate 
WHERE wko_mst_assetno = @assetnumber
AND site_cd = 'QMS'

UPDATE wko_det
SET wko_det_perm_id = @cliniczone ,
wko_det_varchar4 = @cliniczone ,
wko_det_chg_costcenter = @costcenter,
wko_det_note1 = @clinicname,
wko_det_varchar3 = @clinicaddress ,
wko_det_varchar1 = @clinictype ,
wko_det_customer_cd = @newcliniccode ,
wko_det_varchar2 = @cliniccategory,
audit_user = @audituser, 
audit_date = @auditdate 
from	wko_mst (nolock) ,
		wko_det (nolock)
WHERE wko_mst.rowid = wko_det.mst_rowid
and wko_mst.site_cd = wko_det.site_cd
AND wko_mst.site_cd = 'QMS'
and wko_mst_assetno = @assetnumber
--and wko_det_customer_cd = @oldcliniccode


/* Update in Work Request matser Screen*/

UPDATE wkr_mst
SET wkr_mst_work_area = @cliniccircle ,
wkr_mst_chg_costcenter = @costcenter ,
wkr_mst_assetlocn = @cliniclocation ,
audit_user = @audituser, 
audit_date = @auditdate 
WHERE wkr_mst_assetno = @assetnumber
AND site_cd = 'QMS'

UPDATE wkr_det
SET 
wkr_det_note1 = @clinicname,
wkr_det_varchar1 = @clinictype ,
wkr_det_varchar2 = @cliniccategory,
wkr_det_varchar3 = @clinicaddress ,
wkr_det_varchar4 = @cliniczone ,
wkr_det_cus_code = @newcliniccode ,
audit_user = @audituser, 
audit_date = @auditdate 
from	wkr_mst (nolock) ,
		wkr_det (nolock)
WHERE wkr_mst.rowid = wkr_det.mst_rowid
and wkr_mst.site_cd = wkr_det.site_cd
AND wkr_mst.site_cd = 'QMS'
and wkr_mst_assetno = @assetnumber
--and wkr_det_cus_code = @oldcliniccode

/*UPDATE PPM SCHEDULE SCREEN*/

update prm_mst 
set prm_mst_assetlocn = @cliniclocation,
	audit_user = @audituser ,
	audit_date = @auditdate
where site_cd = 'QMS'
and prm_mst_assetno =  @assetnumber

update prm_det
set prm_det_chg_costcenter  = @cliniclocation,
prm_det_work_area = @cliniccircle ,
prm_det_varchar1 = @clinictype ,
prm_det_varchar2 = @cliniccategory ,
prm_det_varchar3 = @clinicaddress ,
prm_det_varchar4 = @cliniczone ,
prm_det_note1 = @clinicname,
prm_det_customer_cd = @newcliniccode,
audit_user = @audituser ,
audit_date = @auditdate
from	prm_mst (nolock) ,
		prm_det (nolock)
WHERE prm_mst.rowid = prm_det.mst_rowid
and prm_mst.site_cd = prm_det.site_cd
AND prm_mst.site_cd = 'QMS'
and prm_mst_assetno =  @assetnumber

*/

update clinic_code_update_table
set updated = 'Yes'
where asset_number =  @assetnumber
and  updated = 'No'

Fetch Next from clinic_cursor into 
@assetnumber ,@newcliniccode,@oldcliniccode,@status,@state

END

Close clinic_cursor
Deallocate clinic_cursor

--select * from ast_mst (nolock) ,
--		ast_det (nolock)
--WHERE ast_mst.rowid = ast_det.mst_rowid
--and ast_mst.site_cd = ast_det.site_cd
--AND ast_mst.site_cd = 'QMS'
--and ast_mst_asset_no = 'PRK003823'

--select * from	wko_mst (nolock) ,
--		wko_det (nolock)
--WHERE wko_mst.rowid = wko_det.mst_rowid
--and wko_mst.site_cd = wko_det.site_cd
--AND wko_mst.site_cd = 'QMS'
--and wko_mst_assetno = 'PRK003823'

--select * from	wkr_mst (nolock) ,
--		wkr_det (nolock)
--WHERE wkr_mst.rowid = wkr_det.mst_rowid
--and wkr_mst.site_cd = wkr_det.site_cd
--AND wkr_mst.site_cd = 'QMS'
--and wkr_mst_assetno = 'PRK003823'

--select * from	prm_mst (nolock) ,
--		prm_det (nolock)
--WHERE prm_mst.rowid = prm_det.mst_rowid
--and prm_mst.site_cd = prm_det.site_cd
--AND prm_mst.site_cd = 'QMS'
--and prm_mst_assetno =  'PRK003823'

