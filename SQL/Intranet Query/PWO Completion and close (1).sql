----drop table ppm_completion_table
----go
----Create table ppm_completion_table
----(asset_number varchar(100),
----newPwonumber varchar(100),
----oldpwonumber varchar(100),
----state varchar(100),
----completiondate datetime ,
----updated varchar(3))

--select distinct wko_mst_wo_no
-- from wko_mst  ,
-- ppm_completion_table 
--where  wko_mst_wo_no = newPwonumber
--and site_cd = 'QMS'
--and wko_mst_status = 'CLO'
--and year(wko_mst_org_date) = 2017

Declare @audituser varchar(100) = 'tomms'
Declare @auditdate datetime = getdate()
Declare @pwo_number varchar(100) 
Declare @remarks_pwo varchar(100) 
Declare @completion datetime 
Declare @assetnumber varchar(100)
Declare @mst_rowid int 

Declare pwo_cursor cursor for
select asset_number,
newPwonumber,
oldpwonumber,
completiondate
from ppm_completion_table (nolock)
where updated = 'No'
--and asset_number ='MLK006607'

open pwo_cursor
Fetch Next from pwo_cursor into 
@assetnumber ,@pwo_number,@remarks_pwo,@completion

WHILE @@FETCH_STATUS = 0   
BEGIN 

Select @mst_rowid  = Rowid
from wko_mst(nolock)
where wko_mst_wo_no = @pwo_number

UPDATE wko_mst 
SET wko_mst_status = 'CMP', audit_user = @audituser, audit_date = @auditdate 
WHERE RowID = @mst_rowid 

UPDATE wko_det 
SET  wko_det_cmpl_date = @completion, audit_user = @audituser, audit_date = @auditdate 
WHERE mst_RowID = @mst_rowid 

update wko_sts 
SET wko_sts_end_date = @completion , wko_sts_duration =0 , audit_user =@audituser , audit_date =@auditdate 
WHERE wko_sts_end_date IS NULL AND site_cd ='QMS' AND wko_sts_wo_no =@pwo_number AND wko_sts_status = 'OPE' 


INSERT wko_sts ( site_cd , mst_RowID , wko_sts_wo_no , wko_sts_status , wko_sts_originator , wko_sts_start_date , wko_sts_end_date , wko_sts_duration , audit_user , audit_date )
 VALUES ( 'QMS' , @mst_rowid , @pwo_number , 'CMP' , @audituser , @completion , NULL , NULL , @audituser , @auditdate )

UPDATE wko_mst 
SET wko_mst_status = 'CLO', audit_user = @audituser, audit_date = @auditdate 
WHERE RowID = @mst_rowid 

UPDATE wko_det 
SET  wko_det_clo_date = @completion, wko_det_wo_open = 'N',wko_det_act_code = 'PPM',wko_det_corr_action = 'PPM DONE - '+@remarks_pwo, audit_user = @audituser, audit_date = @auditdate 
WHERE mst_RowID = @mst_rowid 

update wko_sts 
SET wko_sts_end_date = @completion, wko_sts_duration =0 , audit_user =@audituser , audit_date =@auditdate 
WHERE wko_sts_end_date IS NULL AND site_cd ='QMS' AND wko_sts_wo_no =@pwo_number AND wko_sts_status ='CMP' 


INSERT wko_sts ( site_cd , mst_RowID , wko_sts_wo_no , wko_sts_status , wko_sts_originator , wko_sts_start_date , wko_sts_end_date , wko_sts_duration , audit_user , audit_date )
 VALUES ( 'QMS' , @mst_rowid , @pwo_number , 'CLO' , @audituser , @completion , NULL , NULL , @audituser , @auditdate )

update prm_mst 
set prm_mst_curr_wo  =  NULL,
	prm_mst_lpm_closed_date = convert(datetime,convert(date,@completion)), 
	audit_user = @audituser ,
	audit_date = @auditdate
where prm_mst_curr_wo =  @pwo_number

update ppm_completion_table
set updated = 'Yes'
where newPwonumber =  @pwo_number

Fetch Next from pwo_cursor into 
@assetnumber ,@pwo_number,@remarks_pwo,@completion

END

Close pwo_cursor
Deallocate pwo_cursor

--wko_mst ,
--wko_det 
--where wko_mst.rowid = wko_det.mst_RowID
--and left(wko_mst_wo_no,3) = 'PWO'
--and wko_mst_wo_no = 'PWO236387'

--prm_mst 
----where prm_mst_pm_no = 'PRM130378'
--select wko_mst_assetno,wko_mst_wo_no,wko_det_cmpl_date,wko_det_sc_date,wko_det_clo_date
--from 
--wko_mst ,
--wko_det 
--where wko_mst.rowid = wko_det.mst_RowID
--and left(wko_mst_wo_no,3) = 'PWO'
--and wko_mst_assetno like 'SWK%'
--and wko_mst_status = 'OPE'