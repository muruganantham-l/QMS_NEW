

Declare @audituser varchar(100) = 'tomms'
Declare @auditdate datetime = getdate()
Declare @pwo_number varchar(100) 
Declare @remarks_pwo varchar(100) 
Declare @completion datetime 
Declare @assetnumber varchar(100)
Declare @mst_rowid int 
Declare @WODate datetime 

set nocount on

Declare pwo_cursor cursor for
select   asset_number,
newPwonumber,
oldpwonumber,
completiondate
from ppm_completion_table (nolock)
where updated = 'No'
and [state] = 'Open'
and error_log is NULL

open pwo_cursor
Fetch Next from pwo_cursor into 
@assetnumber ,@pwo_number,@remarks_pwo,@completion

WHILE @@FETCH_STATUS = 0   
BEGIN 

if exists(select '*' from  wko_mst(nolock)
where wko_mst_assetno = @assetnumber
and wko_mst_wo_no  = @pwo_number
and wko_mst_status in('CMP', 'CLO'))
	begin 

				Select @mst_rowid  = Rowid ,@WODate = wko_mst_org_date
				from wko_mst(nolock)
				where wko_mst_assetno = @assetnumber
				and wko_mst_wo_no = @pwo_number
				AND site_cd ='QMS'

				--UPDATE wko_mst 
				--SET wko_mst_status = 'CMP', audit_user = @audituser, audit_date = @auditdate 
				--WHERE RowID = @mst_rowid 

				UPDATE wko_det with (updlock)
				SET  wko_det_cmpl_date = NULL, audit_user = @audituser, audit_date = @auditdate 
				WHERE site_cd ='QMS' 
				and mst_RowID = @mst_rowid  

				update wko_sts with (updlock)
				SET wko_sts_end_date = NULL , wko_sts_duration =NULL , audit_user =@audituser , audit_date =@auditdate 
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no =@pwo_number 
				AND wko_sts_status = 'OPE' 
				and wko_sts_end_date IS NOT NULL 
				
				UPDATE wko_mst with (updlock)
				SET wko_mst_status = 'OPE', audit_user = @audituser, audit_date = @auditdate 
				WHERE RowID = @mst_rowid 
				and wko_mst_wo_no = @pwo_number
				and  wko_mst_assetno = @assetnumber
				AND site_cd ='QMS'

				UPDATE wko_det with (updlock)
				SET  wko_det_clo_date = NULL, wko_det_wo_open = 'Y',wko_det_act_code = NULL ,wko_det_corr_action = NULL, audit_user = @audituser, audit_date = @auditdate 
				WHERE  site_cd ='QMS' 
				and mst_RowID = @mst_rowid 

				Delete from wko_sts 
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no =@pwo_number 
				AND wko_sts_status ='CMP' 

				Delete from wko_sts 
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no =@pwo_number 
				AND wko_sts_status ='CLO' 


				update prm_mst with (updlock)
				set prm_mst_curr_wo  =  @pwo_number,
					--prm_mst_lpm_closed_date = convert(datetime,convert(date,@completion)), 
					audit_user = @audituser ,
					audit_date = @auditdate
				where site_cd = 'QMS'
				and prm_mst_assetno = @assetnumber

				update prm_mst with (updlock)
				set prm_mst_lpm_date =  @WODate -- Dateadd(yy,-1,prm_mst_lpm_date) 
				where site_cd = 'QMS'
				and prm_mst_assetno = @assetnumber
				and prm_mst_freq_code = '1'
				--and prm_mst_curr_wo is NULL

				update prm_mst with (updlock)
				set prm_mst_next_due = @WODate --Dateadd(yy,1,prm_mst_lpm_date)
				,prm_mst_next_create = dateadd(mm,-1,@WODate) -- dateadd(mm,11,prm_mst_lpm_date)
				,audit_date = getdate()
				where site_cd = 'QMS'
				and prm_mst_assetno = @assetnumber
				--and prm_mst_freq_code = '1'
				--and prm_mst_curr_wo is NULL

				update prm_mst with (updlock)
				set prm_mst_lpm_date =  @WODate --Dateadd(mm,-6,prm_mst_lpm_date )
				where site_cd = 'QMS'
				and prm_mst_assetno = @assetnumber
				and prm_mst_freq_code = '2'
				--and prm_mst_curr_wo is NULL

				update prm_mst with (updlock)
				set prm_mst_next_due = @WODate --Dateadd(mm,6,prm_mst_lpm_date)
				,prm_mst_next_create = dateadd(mm,-1,@WODate) --dateadd(mm,5,prm_mst_lpm_date)
				,audit_date = getdate()
				where site_cd = 'QMS'
				and prm_mst_assetno = @assetnumber
				and prm_mst_freq_code = '2'
				--and prm_mst_curr_wo is NULL

				update ppm_completion_table with (updlock)
				set updated = 'Yes'
				where asset_number= @assetnumber
				and newPwonumber  =  @pwo_number
				and oldpwonumber  = @remarks_pwo
				and updated = 'No'

				update ppm_completion_table with (updlock)
				set updated = 'Yes'
				where asset_number= @assetnumber
				and newPwonumber  =  @pwo_number
				and oldpwonumber  = @remarks_pwo
				and updated = 'No'

	end
else
	begin 
		
		update ppm_completion_table with (updlock)
		set error_log = 'Combination Error :- WO No :'+@pwo_number+' Asset No :'+@assetnumber+' Status : Open '
		where asset_number= @assetnumber
		and newPwonumber  =  @pwo_number
		and oldpwonumber  = @remarks_pwo
		and updated = 'No'

	end

Fetch Next from pwo_cursor into 
@assetnumber ,@pwo_number,@remarks_pwo,@completion

END

Close pwo_cursor
Deallocate pwo_cursor

--Alter table ppm_completion_table
--add error_log varchar(500)
--Alter table ppm_completion_table
--add createtime datetime default getdate()
--wko_mst ,
--wko_det 
--where wko_mst.rowid = wko_det.mst_RowID
--and left(wko_mst_wo_no,3) = 'PWO'
--and wko_mst_wo_no = 'PWO236387'

----prm_mst 
----where prm_mst_assetno = 'SLR000921'
--select wko_mst_assetno,wko_mst_wo_no,wko_det_cmpl_date,wko_det_sc_date,wko_det_clo_date
--from 
--wko_mst ,
--wko_det 
--where wko_mst.rowid = wko_det.mst_RowID
--and left(wko_mst_wo_no,3) = 'PWO'
--and wko_mst_assetno like 'SWK%'
--and wko_mst_status = 'OPE'

set nocount off


-- prm_mst (nolock)
--where site_cd = 'QMS'
--and prm_mst_assetno = ''