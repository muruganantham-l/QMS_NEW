
Declare @audituser varchar(100) = 'tomms'
Declare @auditdate datetime = getdate()
Declare @pwo_number varchar(100) 
Declare @remarks_pwo varchar(100) 
Declare @completion datetime 
Declare @assetnumber varchar(100)
Declare @mst_rowid int 

Declare pwo_cursor cursor for
select top 200 asset_number,
newPwonumber,
oldpwonumber,
completiondate
from ppm_completion_table (nolock)
where updated = 'Yes'
--and asset_number ='MLK001047'

open pwo_cursor
Fetch Next from pwo_cursor into 
@assetnumber ,@pwo_number,@remarks_pwo,@completion

WHILE @@FETCH_STATUS = 0   
BEGIN 

Select @mst_rowid  = Rowid
from wko_mst(nolock)
where wko_mst_wo_no = @pwo_number


UPDATE wko_mst 
SET wko_mst_status = 'OPE', audit_user = @audituser, audit_date = @auditdate 
WHERE RowID = @mst_rowid 

UPDATE wko_det 
SET  wko_det_cmpl_date = NULL, audit_user = @audituser, audit_date = @auditdate 
WHERE mst_RowID = @mst_rowid 


update wko_sts 
SET wko_sts_end_date = NULL , wko_sts_duration = NULL , audit_user =@audituser , audit_date =@auditdate 
WHERE wko_sts_end_date IS NOT NULL AND site_cd ='QMS' AND wko_sts_wo_no =@pwo_number AND wko_sts_status = 'OPE' 

Delete from wko_sts
where site_cd = 'QMS'
and mst_RowID = @mst_rowid
and wko_sts_wo_no =  @pwo_number
and wko_sts_status = 'CMP'


UPDATE wko_det 
SET  wko_det_clo_date = NULL, wko_det_wo_open = 'Y',wko_det_act_code = NULL,wko_det_corr_action = NULL , audit_user = @audituser, audit_date = @auditdate 
WHERE mst_RowID = @mst_rowid 

Delete from wko_sts
where site_cd = 'QMS'
and mst_RowID = @mst_rowid
and wko_sts_wo_no =  @pwo_number
and wko_sts_status = 'CLO'

Declare @prmnumber nvarchar(100)

select 
 @prmnumber = wko_det_pm_idno
from wko_det (nolock) 
 WHERE mst_RowID = @mst_rowid  


update prm_mst 
set prm_mst_curr_wo  =  @pwo_number,
	--prm_mst_lpm_closed_date = convert(datetime,convert(date,@completion)), 
	audit_user = @audituser ,
	audit_date = @auditdate
where prm_mst_pm_no  =  @prmnumber

update ppm_completion_table
 set updated = 'No'
where asset_number = @assetnumber 
and newPwonumber = @pwo_number
and oldpwonumber= @remarks_pwo
and updated = 'Yes'

Fetch Next from pwo_cursor into 
@assetnumber ,@pwo_number,@remarks_pwo,@completion

END

Close pwo_cursor
Deallocate pwo_cursor

