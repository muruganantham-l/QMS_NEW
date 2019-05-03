alter proc wo_reopen
@wono varchar(30) = null
as
begin
set NOCOUNT ON

declare @sysdate datetime = getdate() , @mst_rowid numeric(9)

update m set wko_mst_status = 'OPE' from wko_mst m where m.wko_mst_wo_no = @wono

update d set wko_det_cmpl_date = null,wko_det_clo_date = NULL,@mst_rowid = mst_RowID,wko_det_wo_open='Y'
 from wko_mst m join wko_det d on m.RowID = d.mst_RowID
 and m.wko_mst_wo_no = @wono

update s set 
wko_sts_end_date = @sysdate,wko_sts_duration=0
from wko_sts s 
where s.wko_sts_wo_no = @wono
and s.wko_sts_status in ('CMP','CLO')  
and wko_sts_end_date is null
 
insert wko_sts (site_cd,mst_RowID,wko_sts_wo_no,wko_sts_status,wko_sts_originator,wko_sts_start_date,audit_user,audit_date)
SELECT 'QMS',@mst_rowid,@wono,'OPE','tomms',@sysdate,'tomms',@sysdate

 
--SELECT * from wko_sts where wko_sts_wo_no = 'pwo416874'


set NOCOUNT OFF
end
