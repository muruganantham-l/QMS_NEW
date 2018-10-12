Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE Procedure Sp_Dental_Accessory_report_out
@state nvarchar(100),
@District nvarchar(200),
@category nvarchar(500),
@Benumber nvarchar(100)
as
begin

Declare @guid nvarchar(200)


if @state in ('ALL','0')
begin
set @state = '%'
end
else
begin 
set @state = '%'+@state
end


if @District in  ('ALL','0','')
begin
set @District = NULL
end

if @category in  ('ALL','0')
begin
set @category = '%'
end

if isnull(@Benumber,'') in  ('ALL','0','')
begin
set @Benumber = '%'
end


select @guid = newid()

select * from accessory_report_tab (Nolock) 
where BECategory like @category
and State like @state
and District = isnull(@District,District)
and BENumber like @Benumber
and category is not null
and valid is NULL
order by rowid

End


----wko_det
----where wko_det_varchar8 = 'Purchase Biomedical'

--update wko_det
----set  wko_det_varchar8 = 'Purchase Biomedical' , audit_date = getdate()
--where wko_det_varchar8 = 'New Biomedical'

----select distinct BECategory from accessory_report_tab


update accessory_report_tab
--set NameAccessory = 'Operating light'
where  AccessoryNumber like '%-7'
and NameAccessory='Air Compressor'
and valid is NULL

update accessory_report_tab
--set NameAccessory = 'Air Compressor'
where  NameAccessory='Operating light'
and valid is NULL

accessory_report_tab
where AccessoryNumber like '%-4'
and NameAccessory='Air Compressor'

accessory_report_tab
where NameAccessory='Operating light'

update ast_mst
--set ast_mst_asset_grpcode='12-351',ast_mst_asset_longdesc = 'Lights, Dental'--,ast_mst_asset_shortdesc  = 'Operating light' , audit_date = getdate()
where ast_mst_asset_no like '%-5'
and  ast_mst_asset_grpcode ='10-972'
--and ast_mst_asset_shortdesc= 'Air Compressor'

update ast_mst
--set ast_mst_asset_grpcode ='10-972',ast_mst_asset_longdesc= 'Compressors, Medical-Air'--,ast_mst_asset_shortdesc  = 'Air Compressor' , audit_date = getdate()
where ast_mst_asset_no like '%-7'
--and ast_mst_asset_grpcode='12-351'
and ast_mst_asset_shortdesc= 'Air Compressor'

sp_tables 'ast_%%'

update ast_rat
--set ast_rat_desc = 'Lights, Dental , '+right(ast_rat_desc,11)
where  ast_rat_desc like '%Lights, Dental%-5'
--and audit_date = '2017-07-07 09:09:10.057'
order by mst_RowID 
 Air Compressor, WPL000007-5

 update ast_rat
set ast_rat_desc = 'Compressors, Medical-Air '+right(ast_rat_desc,13)
where  ast_rat_desc like '%Lights%Dental%-7'
--and audit_date = '2017-07-25 12:56:33.160'
order by mst_RowID 

select distinct  'Compressors, Medical-Air '+right(ast_rat_desc,13) from ast_rat
--set ast_rat_desc = 'Lights, Dental'+right(ast_rat_desc,11)
where  ast_rat_desc like '%Lights%Dental%-7'



 Compressors, Medical-Air, WPL000594-5
dELETE FROM  ast_rat
where  ast_rat_desc like '%Lights%Dental%-7'
and audit_date = '2017-07-25 12:56:33.160'

ast_rat
where ast_rat_desc like '%Air%-7'
and  not in (
select rowid from  


--insert into ast_rat (site_cd,mst_RowID , ast_rat_uom,ast_rat_rating,ast_rat_desc,audit_user,audit_date)
--Select  mst2.site_cd , mst2.rowid ,'EACH',1,mst1.ast_mst_asset_longdesc+', '+mst1.ast_mst_asset_no  ,'tomms',getdate()
--from 
--ast_mst mst1(nolock) ,
--ast_mst mst2(nolock)
--where mst1.ast_mst_asset_no like '%-7'
--and mst1.ast_mst_asset_shortdesc= 'Air Compressor'
--and mst1.ast_mst_parent_id = mst2.ast_mst_asset_no
--and mst1.ast_mst_parent_id in(
--select ast_mst_asset_no
--from ast_mst
--where ast_mst_asset_no in (select ast_mst_parent_id from ast_mst
--where ast_mst_asset_no like '%-7'
--and ast_mst_asset_shortdesc= 'Air Compressor' )
--and rowid not in (select mst_rowid from ast_rat
--where ast_rat_desc like '%Air%-7'))

sp_stored_procedures '%camms%'

Sp_inupd_Dms_camms_Asset_inbound_tab;1


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
and ast_mst_asset_no like '%-7'
and ast_mst_asset_shortdesc= 'Air Compressor'
 
update ast_det
set ast_det_asset_cost   = ast_grp_purchase_cost,
ast_det_numeric1 = convert(numeric(13,2),ast_grp_purchase_cost * (ast_grp_maintenance_rate_west/100.00)), 
ast_det_numeric2 = ast_grp_maintenance_rate_west, 
ast_det_numeric8 =isnull(convert(numeric(13,2),(ast_grp_purchase_cost * (ast_grp_maintenance_rate_west/100.00))/12.00),0.0) ,
ast_det_numeric9 = isnull(ast_grp_rental_value,0.0)
,ast_det_varchar10 = ast_grp_maintenance_type
,ast_det_varchar11=ast_grp_maint_freq
,ast_det_varchar12=ast_grp_classification
from ast_mst (nolock) , 
ast_grp (nolock),
ast_det (nolock)
where  ast_mst.rowid = ast_det.mst_RowID
and ast_grp.ast_grp_grp_cd = ast_mst.ast_mst_asset_grpcode
and ast_det_varchar9		= 'WM'
and ast_mst.site_cd		= ast_det.site_cd
and ast_mst_asset_no like '%-7'
and ast_mst_asset_shortdesc= 'Air Compressor'

update ast_det
set ast_det_asset_cost   = ast_grp_purchase_cost,
ast_det_numeric1 = convert(numeric(13,2),ast_grp_purchase_cost * (ast_grp_maintenance_value_east/100.00)),
ast_det_numeric2 = ast_grp_maintenance_rate_east, 
ast_det_numeric8 = isnull(convert(numeric(13,2),(ast_grp_purchase_cost * (ast_grp_maintenance_value_east/100.00))/12.00),0.0) ,
ast_det_numeric9 = isnull(ast_grp_rental_value,0.0)
,ast_det_varchar10 = ast_grp_maintenance_type
,ast_det_varchar11=ast_grp_maint_freq
,ast_det_varchar12=ast_grp_classification
from ast_mst (nolock) , 
ast_grp (nolock),
ast_det (nolock)
where  ast_mst.rowid = ast_det.mst_RowID
and ast_grp.ast_grp_grp_cd = ast_mst.ast_mst_asset_grpcode
and ast_det_varchar9	= 'EM'
and ast_mst.site_cd		= ast_det.site_cd
and ast_mst_asset_no like '%-7'
and ast_mst_asset_shortdesc= 'Air Compressor'

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
and ast_mst_asset_no like '%-5'
and ast_mst_asset_shortdesc= 'Operating light'
 
update ast_det
set ast_det_asset_cost   = ast_grp_purchase_cost,
ast_det_numeric1 = convert(numeric(13,2),ast_grp_purchase_cost * (ast_grp_maintenance_rate_west/100.00)), 
ast_det_numeric2 = ast_grp_maintenance_rate_west, 
ast_det_numeric8 =isnull(convert(numeric(13,2),(ast_grp_purchase_cost * (ast_grp_maintenance_rate_west/100.00))/12.00),0.0) ,
ast_det_numeric9 = isnull(ast_grp_rental_value,0.0)
,ast_det_varchar10 = ast_grp_maintenance_type
,ast_det_varchar11=ast_grp_maint_freq
,ast_det_varchar12=ast_grp_classification
from ast_mst (nolock) , 
ast_grp (nolock),
ast_det (nolock)
where  ast_mst.rowid = ast_det.mst_RowID
and ast_grp.ast_grp_grp_cd = ast_mst.ast_mst_asset_grpcode
and ast_det_varchar9		= 'WM'
and ast_mst.site_cd		= ast_det.site_cd
and ast_mst_asset_no like '%-5'
and ast_mst_asset_shortdesc= 'Operating light'

update ast_det
set ast_det_asset_cost   = ast_grp_purchase_cost,
ast_det_numeric1 = convert(numeric(13,2),ast_grp_purchase_cost * (ast_grp_maintenance_value_east/100.00)),
ast_det_numeric2 = ast_grp_maintenance_rate_east, 
ast_det_numeric8 = isnull(convert(numeric(13,2),(ast_grp_purchase_cost * (ast_grp_maintenance_value_east/100.00))/12.00),0.0) ,
ast_det_numeric9 = isnull(ast_grp_rental_value,0.0)
,ast_det_varchar10 = ast_grp_maintenance_type
,ast_det_varchar11=ast_grp_maint_freq
,ast_det_varchar12=ast_grp_classification
from ast_mst (nolock) , 
ast_grp (nolock),
ast_det (nolock)
where  ast_mst.rowid = ast_det.mst_RowID
and ast_grp.ast_grp_grp_cd = ast_mst.ast_mst_asset_grpcode
and ast_det_varchar9	= 'EM'
and ast_mst.site_cd		= ast_det.site_cd
and ast_mst_asset_no like '%-5'
and ast_mst_asset_shortdesc= 'Operating light'

	insert into ast_aud
	(site_cd,mst_RowID,ast_aud_asset_no,ast_aud_status,ast_aud_originator,ast_aud_start_date,ast_aud_end_date,ast_aud_duration,audit_user,
	audit_date)
	select ast_mst.site_cd ,ast_mst.RowID,ast_mst_asset_no,ltrim(rtrim(ast_mst_asset_status)),
	'Tomms',ast_mst_create_date,NULL,0,'Tomms',ast_mst_create_date
	from ast_mst  (nolock)
	,ast_det (nolock)
	where ast_mst.rowid = ast_det.mst_RowID 
	and ast_mst.site_cd	= ast_det.site_cd
	and not exists (select '*'  from ast_aud where ast_mst.site_cd = ast_aud.site_cd and ast_mst.RowID = ast_aud.mst_RowID and ast_mst_asset_no =  ast_aud_asset_no )

	--select * from ast_mst
	--where rowid not in (select mst_rowid from ast_aud )

	select top 48420 * from 
	
	--update ast_aud 
	--set audit_date = getdate()
	--where RowID >=181577 
	
	order by RowID desc
	