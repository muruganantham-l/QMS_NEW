declare @temp table
(

sno      int identity(1,1)
,wono    varchar(100)
,wo_date datetime
)

insert @temp (wono,wo_date)
select [WO Number], left(concat(cast(date as date) ,space(1), cast(time as time)),23) from pwo_cmp_2019
--where no BETWEEN 1 and 790
 
declare @tot_count int 
,@curr_row int = 1
,@wono    varchar(100)
,@wo_date datetime

SELECT @tot_count = count(*) from @temp

while (@curr_row <= @tot_count)
begin

select   @wono = wono,@wo_date = wo_date
from     @temp
where    sno = @curr_row

exec complete_pwo @wono,@wo_date

set @curr_row = @curr_row + 1
end
/*
--after patch check wko_sts table is duplicate or not by status
alter   proc complete_pwo
@wono varchar(100)
,@cmpl_date datetime
as
begin
set NOCOUNT ON

declare @sysdate datetime = getdate()
,@rowid numeric(12)
,@audit_user varchar(100) = 'Patch'

if exists (SELECT '' from wko_mst WHERE wko_mst_wo_no  = @wono and wko_mst_wo_no like 'pwo%')
begin

select @rowid = rowid from wko_mst (NOLOCK) where wko_mst_wo_no = @wono

 UPDATE wko_mst 
SET wko_mst_status = 'CMP', audit_user = @audit_user, audit_date = @sysdate 
WHERE RowID = @rowid  
 
 UPDATE wko_det 
SET   wko_det_cmpl_date = @cmpl_date, audit_user = @audit_user, audit_date = @sysdate 
,wko_det_wo_open = 'N',wko_det_act_code = 'PPM',wko_det_corr_action = 'PREVENTIVE MAINTENANCE', wko_det_work_type= 'PM'
WHERE mst_RowID = @rowid  

 update wko_sts 
SET wko_sts_end_date =@cmpl_date , wko_sts_duration =0 , audit_user =@audit_user , audit_date =@sysdate 
WHERE wko_sts_end_date IS NULL AND site_cd ='QMS' AND wko_sts_wo_no =@wono AND wko_sts_status = 'OPE'  
 



INSERT wko_sts ( site_cd , mst_RowID , wko_sts_wo_no , wko_sts_status
 , wko_sts_originator , wko_sts_start_date , wko_sts_end_date 
 , wko_sts_duration , audit_user , audit_date )
  VALUES ( 'QMS' , @rowid , @wono , 'CMP' , 'tomms' , @cmpl_date , NULL , NULL , @audit_user , @sysdate )
  
end
set NOCOUNT off
end


*/