Alter procedure Sp_inupd_Dms_camms_Asset_inbound_tab
@Guid nvarchar(200)
as 
begin

Set nocount on

DECLARE @site_cd NVARCHAR(100) = 'QMS'
DECLARE @createddate datetime = getdate()

--Truncate table Dms_camms_Asset_inbound_tab

/* Update the BE Category Code and validate*/

Update tab
set [Is Valid]=  'N' ,
	[Remarks] =  'BE Number cannot be Blank. Please check and Proceed. '
from Dms_camms_Asset_inbound_tab tab (nolock) 
where  [Guid] = @Guid
and [BE No] IS NULL


Update tab
set [Is Valid]=  'N' ,
	[Remarks] =  isnull([Remarks],'') +'1.BE Number Already Exists in CAMMS. Please check and Proceed. BE Number : '+[BE No]
from Dms_camms_Asset_inbound_tab tab (nolock) ,
	ast_mst mst(nolock)
where  site_cd =  @site_cd
and [Guid] = @Guid
and ast_mst_asset_no = [BE No]


/* Update the BE Category Code and validate*/

Update tab
set [BE Category] = ast_grp_grp_cd
from Dms_camms_Asset_inbound_tab tab (nolock) ,
	ast_grp grp(nolock)
where grp.column5 = tab.[Package ID]
and  site_cd =  @site_cd
and [Guid] = @Guid


/* Update the BE Category Code and validate*/

Update tab
set  [Is Valid]=  'N' ,
	[Remarks] =  isnull([Remarks],'') +' 2.BE Category & Package ID is not valid. Please check and Proceed. BE Number : '+[BE No]
from Dms_camms_Asset_inbound_tab tab (nolock) 
where  [Guid] = @Guid
and [BE Category] IS null


/*Insert the data into mst Table */
	INSERT INTO ast_mst (
		site_cd
		,ast_mst_asset_no
		,ast_mst_asset_type
		,ast_mst_asset_grpcode
		,ast_mst_asset_status
		,ast_mst_cri_factor
		,ast_mst_asset_shortdesc
		,ast_mst_asset_longdesc
		,audit_user
		,audit_date
		,ast_mst_parent_flag
		,ast_mst_auto_no
		,ast_mst_create_by
		,ast_mst_create_date
		)
	SELECT @site_cd
		,[BE NO]
		,ast_grp_group
		,[BE Category]
		,'ACT'
		,ast_grp_cri_factor
		,ast_grp_general_name
		,ast_grp_category
		,'Patch'
		,@createddate
		,'0'
		,'0'
		,'Patch'
		,@createddate
	FROM Dms_camms_Asset_inbound_tab tab(NOLOCK),
		 ast_grp grp(nolock)
	WHERE tab.GUID = @guid
	and site_cd = @site_cd
	and ast_grp_grp_cd = [BE Category]
	and [Is Valid] IS NULL

/*Insert the data into detail Table */
	INSERT INTO ast_det (
		site_cd
		,mst_RowID
		,ast_det_asset_cost
		,ast_det_mtdlabcost
		,ast_det_mtdmtlcost
		,ast_det_mtdconcost
		,ast_det_ytdlabcost
		,ast_det_ytdmtlcost
		,ast_det_ytdconcost
		,ast_det_ltdlabcost
		,ast_det_ltdmtlcost
		,ast_det_ltdconcost
		,ast_det_taxable
		,ast_det_varchar2
		,ast_det_varchar4
		,ast_det_varchar10
		,ast_det_varchar11
		,ast_det_varchar12
		,ast_det_varchar15
		,ast_det_varchar16	
		,ast_det_varchar17
		,ast_det_varchar21
		,ast_det_varchar20
		,ast_det_varchar5
		,ast_det_note1
		,ast_det_note2
		,audit_user
		,audit_date
		,ast_det_cus_code
		,ast_det_mfg_cd
		,ast_det_modelno
		,ast_det_varchar29
		)
	SELECT ast_mst.site_cd
		,ast_mst.RowID
		,ast_grp_purchase_cost
		,0
		,0
		,0
		,0
		,0
		,0
		,0
		,0
		,0
		,'N'
		,[Serial No.]
		,'Functioning'
		,ast_grp_maintenance_type
		,ast_grp_maint_freq
		,ast_grp_classification
		,[BE Type]
		,[Supplier Name]
		,[Supplier Contact Person]
		,[Batch]
		,'(35)dlm.KKM(S)-35(1)P/SWASTA/1/93/17JLD.5'
		,[DRN No.]
		,[Clinic Name]
		,[Clinic Address]
		,'Patch'
		,@createddate
		,[Clinic ID]
		,Substring([Product Manufacturer],1,25)
		,[Product Model]
		,[GUID]
	FROM ast_mst(NOLOCK)
		,ast_grp(NOLOCK)
		,Dms_camms_Asset_inbound_tab (NOLOCK)
	WHERE [GUID] = @guid
		AND ast_mst.site_cd = ast_grp.site_cd
		AND ast_grp_grp_cd = ast_mst.ast_mst_asset_grpcode
		AND ast_mst.site_cd = @site_cd
		AND [BE No] = ast_mst_asset_no
		AND [BE Category] = ast_mst_asset_grpcode
		and [Is Valid] IS NULL

/*Update the remaining Data in Master Table*/


update ast_mst
set ast_mst_asset_type   = ast_grp_group, 
ast_mst_cri_factor = ast_grp_cri_factor , 
ast_mst_wrk_grp = ast_grp_classification
from ast_mst (nolock) , 
ast_det (nolock)  , 
ast_grp (nolock)
where  ast_mst.site_cd	= ast_det.site_cd
and ast_mst.site_cd		= ast_grp.site_cd
and ast_mst.rowid		= ast_det.mst_RowID 
and ast_grp.ast_grp_grp_cd = ast_mst.ast_mst_asset_grpcode
and ast_det_varchar29	= @Guid
and ast_mst.site_cd		= @site_cd

update ast_mst
set ast_mst_cost_center = cus_mst_seller, 
ast_mst_work_area = cus_det_email_id, 
ast_mst_asset_code = cus_mst_shipvia,
ast_mst_perm_id = cus_det_province ,
ast_mst_asset_locn = cus_det_city ,
ast_mst_ast_lvl = cus_det_state 
from 
ast_mst (nolock) , 
ast_det (nolock)  , 
cus_mst (nolock) , 
cus_det (nolock)
where ast_mst.site_cd	= ast_det.site_cd
and ast_mst.site_cd		= cus_mst.site_cd
and ast_mst.site_cd		= cus_det.site_cd
and ast_mst.rowid		= ast_det.mst_RowID 
and ast_mst.site_cd		= @site_cd
and ast_det_varchar29	= @Guid
and cus_mst.rowid		= cus_det.mst_RowID 
and cus_mst_customer_cd = ast_det_cus_code

update ast_mst  
set ast_mst_safety_rqmts = 'V4 : New Biomedical' 
from 
ast_mst (nolock) , ast_det (nolock) 
where ast_mst.rowid = ast_det.mst_RowID 
and ast_mst.site_cd	= ast_det.site_cd
and ast_det_varchar29 = @Guid
and ast_mst.site_cd		= @site_cd
and ast_det_varchar15 = 'NBE'

update ast_mst  
set ast_mst_safety_rqmts = 'V5 : Purchase Biomedical' 
from 
ast_mst (nolock) , ast_det (nolock) 
where ast_mst.rowid = ast_det.mst_RowID 
and ast_mst.site_cd	= ast_det.site_cd
and ast_det_varchar29 = @Guid
and ast_mst.site_cd		= @site_cd
and ast_det_varchar15 = 'PBE'

/*Update the remaining Data in Detail Table */

update ast_det
set ast_det_varchar1 = cus_mst_fob, 
	ast_det_varchar9 =cus_mst_acct_no 
from 
ast_mst (nolock) , 
ast_det (nolock)  , 
cus_mst (nolock) , 
cus_det (nolock)
where ast_mst.site_cd	= ast_det.site_cd
and ast_mst.site_cd		= cus_mst.site_cd
and ast_mst.site_cd		= cus_det.site_cd
and ast_mst.rowid		= ast_det.mst_RowID 
and ast_mst.site_cd		= @site_cd
and ast_det_varchar29	= @Guid
and cus_mst.rowid		= cus_det.mst_RowID 
and cus_mst_customer_cd = ast_det_cus_code

update ast_det
set ast_det_asset_cost   = ast_grp_purchase_cost,
ast_det_numeric1 = convert(numeric(13,2),ast_grp_purchase_cost * (ast_grp_maintenance_rate_west/100.00)), 
ast_det_numeric2 = ast_grp_maintenance_rate_west, 
ast_det_numeric8 =isnull(convert(numeric(13,2),(ast_grp_purchase_cost * (ast_grp_maintenance_rate_west/100.00))/12.00),0.0) ,
ast_det_numeric9 = isnull(ast_grp_rental_value,0.0)
from ast_mst (nolock) , 
ast_grp (nolock),
ast_det (nolock)
where  ast_mst.rowid = ast_det.mst_RowID
and ast_grp.ast_grp_grp_cd = ast_mst.ast_mst_asset_grpcode
and ast_det_varchar9		= 'WM'
and ast_mst.site_cd		= ast_det.site_cd
and ast_det_varchar29	= @Guid
and ast_mst.site_cd		= @site_cd

update ast_det
set ast_det_asset_cost   = ast_grp_purchase_cost,
ast_det_numeric1 = convert(numeric(13,2),ast_grp_purchase_cost * (ast_grp_maintenance_rate_east/100.00)),
ast_det_numeric2 = ast_grp_maintenance_rate_east, 
ast_det_numeric8 = isnull(convert(numeric(13,2),(ast_grp_purchase_cost * (ast_grp_maintenance_rate_east/100.00))/12.00),0.0) ,
ast_det_numeric9 = isnull(ast_grp_rental_value,0.0)
from ast_mst (nolock) , 
ast_grp (nolock),
ast_det (nolock)
where  ast_mst.rowid = ast_det.mst_RowID
and ast_grp.ast_grp_grp_cd = ast_mst.ast_mst_asset_grpcode
and ast_det_varchar9	= 'EM'
and ast_mst.site_cd		= ast_det.site_cd
and ast_det_varchar29	= @Guid
and ast_mst.site_cd		= @site_cd

update ast_det  
set ast_det_varchar14 = 'NA', ast_det_varchar15 = 'New Biomedical' 
from 
ast_mst (nolock) , ast_det (nolock) 
where ast_mst.rowid = ast_det.mst_RowID 
and ast_mst.site_cd	= ast_det.site_cd
and ast_det_varchar29 = @Guid
and ast_mst.site_cd		= @site_cd
and ast_det_varchar15 = 'NBE'

update ast_det  
set ast_det_varchar14 = 'NA', ast_det_varchar15 = 'Purchase Biomedical' 
from 
ast_mst (nolock) , ast_det (nolock) 
where ast_mst.rowid = ast_det.mst_RowID
and ast_mst.site_cd	= ast_det.site_cd 
and ast_det_varchar29 = @Guid
and ast_mst.site_cd		= @site_cd
and ast_det_varchar15 = 'PBE'


update ast_det  
set ast_det_varchar14 = 'NA', ast_det_varchar15 = 'New Biomedical' 
from 
ast_mst (nolock) , ast_det (nolock) 
where ast_mst.rowid = ast_det.mst_RowID
and ast_mst.site_cd	= ast_det.site_cd 
and ast_det_varchar29 = @Guid
and ast_mst.site_cd		= @site_cd
and ast_det_varchar15 = 'NBE'

update ast_det  
set ast_det_varchar14 = 'NA', ast_det_varchar15 = 'Purchase Biomedical' 
from 
ast_mst (nolock) , ast_det (nolock) 
where ast_mst.rowid = ast_det.mst_RowID 
and ast_mst.site_cd	= ast_det.site_cd
and ast_det_varchar29 = @Guid
and ast_mst.site_cd		= @site_cd
and ast_det_varchar15 = 'PBE'

/* Upload Asset Audit Information */

update  ast_aud
	set ast_aud_end_date  = dateadd(dd,-1,@createddate)
	from ast_aud (nolock)
	,ast_mst (nolock)
	,ast_det (nolock)
	where ast_aud.site_cd = @site_cd
	and ast_aud.site_cd = ast_mst.site_cd
	and  ast_mst.rowid = ast_det.mst_RowID 
	and ast_mst.site_cd	= ast_det.site_cd
	and ast_mst_asset_no = ast_aud_asset_no
	and ast_aud.mst_RowID = ast_mst.RowID
	and ast_det_varchar29 = @guid
	and ast_aud_end_date is NULL
	and ast_aud_start_date < @createddate

	insert into ast_aud
	(site_cd,mst_RowID,ast_aud_asset_no,ast_aud_status,ast_aud_originator,ast_aud_start_date,ast_aud_end_date,ast_aud_duration,audit_user,
	audit_date)
	select ast_mst.site_cd ,ast_mst.RowID,ast_mst_asset_no,ltrim(rtrim(ast_mst_asset_status)),
	'Patch',@createddate,NULL,0,'Patch',@createddate
	from ast_mst  (nolock)
	,ast_det (nolock)
	where ast_mst.rowid = ast_det.mst_RowID 
	and ast_mst.site_cd	= ast_det.site_cd
	and ast_det_varchar29 = @guid
	and ast_mst.site_cd = @site_cd




set nocount off
end


----Alter table Dms_camms_Asset_inbound_tab
----add [BE Category] nvarchar(100)

----Alter table Dms_camms_Asset_inbound_tab
----add [Is Valid] nvarchar(100)

----Alter table Dms_camms_Asset_inbound_tab
----add [Remarks] nvarchar(Max)

----Truncate table Dms_camms_Asset_inbound_tab

