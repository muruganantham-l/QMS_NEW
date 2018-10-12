
Declare @audituser varchar(100) = 'tomms'
Declare @auditdate datetime = getdate()
Declare @pwo_number varchar(100) 
Declare @remarks_pwo varchar(300) 
Declare @completion datetime 
Declare @assetnumber varchar(100)
	Declare @mst_rowid int 
	Declare @wodate datetime

set nocount on

Declare pwo_cursor cursor for 
select   asset_number,
newPwonumber,
oldpwonumber,
completiondate
from ppm_completion_table (nolock)
where  updated = 'NO' --state like '%PULAU PINANG%'
and error_log is NULL
--and createtime between '2018-03-06 10:36:33' and '2018-03-06 10:38:00'


open pwo_cursor
Fetch Next from pwo_cursor into 
@assetnumber ,@pwo_number,@remarks_pwo,@completion

WHILE @@FETCH_STATUS = 0   
BEGIN 

if exists(select '*' from  wko_mst(nolock)
where wko_mst_assetno = @assetnumber
and wko_mst_wo_no  = @pwo_number
and wko_mst_status in('CMP','CLO'))
	begin 

				Select @mst_rowid  = Rowid , @wodate = wko_mst_org_date
				from wko_mst(nolock)
				where wko_mst_assetno = @assetnumber
				and wko_mst_wo_no = @pwo_number
				AND site_cd ='QMS'

				--UPDATE wko_mst 
				--SET wko_mst_status = 'CMP', audit_user = @audituser, audit_date = @auditdate 
				--WHERE RowID = @mst_rowid 

				UPDATE wko_det with (updlock)
				SET  wko_det_cmpl_date = @completion, audit_user = @audituser, audit_date = @auditdate 
				WHERE site_cd ='QMS' 
				and mst_RowID = @mst_rowid  

				update wko_sts 
				SET wko_sts_end_date = @completion , wko_sts_duration =0 , audit_user =@audituser , audit_date =@auditdate 
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no =@pwo_number 
				AND wko_sts_status = 'OPE' 
				and wko_sts_end_date IS NULL 
				
				if not exists (select '*' from wko_sts (nolock) where site_cd = 'QMS' and mst_RowID = @mst_rowid and wko_sts_status = 'CMP'  )
				begin
					INSERT wko_sts ( site_cd , mst_RowID , wko_sts_wo_no , wko_sts_status , wko_sts_originator , wko_sts_start_date , wko_sts_end_date , wko_sts_duration , audit_user , audit_date )
					VALUES ( 'QMS' , @mst_rowid , @pwo_number , 'CMP' , @audituser , @completion , NULL , NULL , @audituser , @auditdate )
				end

				UPDATE wko_mst 
				SET wko_mst_status = 'CLO', audit_user = @audituser, audit_date = @auditdate 
				WHERE RowID = @mst_rowid 
				and wko_mst_wo_no = @pwo_number
				and  wko_mst_assetno = @assetnumber
				AND site_cd ='QMS'

				UPDATE wko_det with (updlock)
				SET  wko_det_clo_date = @completion, wko_det_wo_open = 'N',wko_det_act_code = 'PPM',wko_det_corr_action = @remarks_pwo, audit_user = @audituser, audit_date = @auditdate 
				WHERE  site_cd ='QMS' 
				and mst_RowID = @mst_rowid 

				update wko_sts 
				SET wko_sts_end_date = @completion, wko_sts_duration =0 , audit_user =@audituser , audit_date =@auditdate 
				WHERE  site_cd ='QMS' 
				AND wko_sts_wo_no =@pwo_number 
				AND wko_sts_status ='CMP' 
				AND wko_sts_end_date IS NULL

				if not exists (select '*' from wko_sts (nolock) where site_cd = 'QMS' and mst_RowID = @mst_rowid and wko_sts_status = 'CLO'  )
				begin
					INSERT wko_sts ( site_cd , mst_RowID , wko_sts_wo_no , wko_sts_status , wko_sts_originator , wko_sts_start_date , wko_sts_end_date , wko_sts_duration , audit_user , audit_date )
					 VALUES ( 'QMS' , @mst_rowid , @pwo_number , 'CLO' , @audituser , @completion , NULL , NULL , @audituser , @auditdate )
				end

				update prm_mst with (updlock)
				set prm_mst_curr_wo  =  NULL,
					prm_mst_lpm_closed_date = convert(datetime,convert(date,@completion)), 
					audit_user = @audituser ,
					audit_date = @auditdate
				where site_cd = 'QMS'
				and prm_mst_assetno = @assetnumber
				and prm_mst_curr_wo =   @pwo_number

				update prm_mst with (updlock)
				set prm_mst_lpm_date = @wodate 
				where site_cd = 'QMS'
				and prm_mst_assetno = @assetnumber
				and prm_mst_freq_code = '1'
				and prm_mst_curr_wo is NULL

				update prm_mst with (updlock)
				set prm_mst_next_due = Dateadd(yy,1,prm_mst_lpm_date)
				,prm_mst_next_create = dateadd(mm,11,prm_mst_lpm_date)
				,audit_date = getdate()
				where site_cd = 'QMS'
				and prm_mst_assetno = @assetnumber
				and prm_mst_freq_code = '1'
				and prm_mst_curr_wo is NULL

				update prm_mst with (updlock)
				set prm_mst_lpm_date = @wodate 
				where site_cd = 'QMS'
				and prm_mst_assetno = @assetnumber
				and prm_mst_freq_code = '2'
				and prm_mst_curr_wo is NULL

				update prm_mst with (updlock)
				set prm_mst_next_due = Dateadd(mm,6,prm_mst_lpm_date)
				,prm_mst_next_create = dateadd(mm,5,prm_mst_lpm_date)
				,audit_date = getdate()
				where site_cd = 'QMS'
				and prm_mst_assetno = @assetnumber
				and prm_mst_freq_code = '2'
				and prm_mst_curr_wo is NULL

				update ppm_completion_table with (updlock)
				set updated = 'Yes'
				where asset_number= @assetnumber
				and newPwonumber  =  @pwo_number
				and oldpwonumber  = @remarks_pwo
				and updated = 'No'

	end
else
	begin 
		
		update ppm_completion_table
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

set nocount off
