ALTER proc wo_wr_without_action_email
as
begin
set nocount on
declare --@sysdate date = getdate(),
@end_date date = DATEADD(dd,-3,getdate())

SELECT * 
from  wkr_mst (NOLOCK) w 
where cast(w.wkr_mst_org_date as DATE) = @end_date
and w.wkr_mst_wr_status = 'W'
 
SELECT *
from wko_mst m (NOLOCK)
join wko_det d (NOLOCK)
on m.RowID = d.mst_RowID
where m.wko_mst_org_date = @end_date
and (d.wko_det_sched_date is NULL or d.wko_det_exc_date is NULL)



set nocount OFF
end