ALTER proc wo_date_update
@wo_no varchar(100) = 'CWO191152'
,@cmpl_date datetime = '2018-11-19 16:29:00.000'
,@response_date datetime = NULL
as
begin
set nocount ON

update d 
set d.wko_det_cmpl_date = isnull(@cmpl_date,d.wko_det_cmpl_date)
,d.wko_det_exc_date = isnull( @response_date,d.wko_det_exc_date)
from	wko_mst m (NOLOCK)
JOIN	wko_det d (NOLOCK)
on m.RowID =d.mst_RowID
and m.wko_mst_wo_no = @wo_no


set nocount OFF
end