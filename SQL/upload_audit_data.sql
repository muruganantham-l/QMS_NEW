ALTER procedure upload_audit_data
@createddate varchar(200),
@createdby varchar(200)
as
begin

Declare @uiid int


select @uiid = max(rowid) from  save_audit_data_tab (nolock) where createdby = @createdby

declare @guid varchar(200)

select @guid = uniqid 
from  save_audit_data_tab (nolock)
where rowid = @uiid
and  createdby = @createdby

/**added by murugan start**/

    update d
	set d.ast_det_varchar28 = Reasonforchange
	from ast_mst (nolock) m
	join bedetail_to_camms_tab (nolock)
	on  guid = @guid 
	and site_cd = 'QMS'
	and ast_mst_asset_no= benumber
	and ast_mst_asset_status = currentstatus
	join ast_det d on m.rowid = d.mst_rowid
	/**added by murugan end**/


/*Update the status change in Asset Register*/
	update  ast_mst
	set ast_mst_asset_status = ltrim(rtrim(Newstatus)) , audit_date = getdate()
	from ast_mst (nolock)
	,bedetail_to_camms_tab (nolock)
	where guid = @guid 
	and site_cd = 'QMS'
	and ast_mst_asset_no= benumber
	and ast_mst_asset_status = currentstatus

	
/*Update the status change in Asset Audit Deatil*/
	
	Select  @createddate = convert(datetime,@createddate,101)

	update  ast_aud
	set ast_aud_end_date  = dateadd(dd,-1,@createddate)
	from ast_aud (nolock)
	,ast_mst (nolock)
	,bedetail_to_camms_tab (nolock)
	where guid = @guid
	and ast_aud.site_cd = 'QMS'
	and ast_aud.site_cd = ast_mst.site_cd
	and ast_mst_asset_no= benumber
	and ast_mst_asset_no = ast_aud_asset_no
	and mst_RowID = ast_mst.RowID
	and ast_aud_end_date is NULL
	And ast_aud_end_date < @createddate

	insert into ast_aud
	(site_cd,mst_RowID,ast_aud_asset_no,ast_aud_status,ast_aud_originator,ast_aud_start_date,ast_aud_end_date,ast_aud_duration,audit_user,	audit_date,column1,column2,column3,column4,column5)	select site_cd ,RowID,ast_mst_asset_no,ltrim
(rtrim(Newstatus)),
	'QMS',@createddate,NULL,0,'QMS',@createddate,NULL,NULL,NULL,NULL,NULL
	from ast_mst  (nolock)
	,bedetail_to_camms_tab (nolock)
	where guid = @guid
	and site_cd = 'QMS'
	and ast_mst_asset_no= benumber

	
end





