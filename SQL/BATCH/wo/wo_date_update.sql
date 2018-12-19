ALTER proc wo_date_update
@wo_no varchar(100) = 'CWO175137'
,@cmpl_date datetime = '2018-12-04 15:30:00.000'
,@response_date datetime = '2018-11-17 16:30:00.000'
,@ack_date datetime = null
,@wo_date datetime = null
as
begin
 

declare @wr_date datetime
,@wo_ack_date datetime
,@wo_clo_date datetime

select @wr_date = w.wkr_mst_org_date,@cmpl_date = isnull(@cmpl_date, d.wko_det_cmpl_date),@response_date = isnull(@response_date,d.wko_det_exc_date),@wo_ack_date = isnull(@ack_date,d.wko_det_sched_date)
,@wo_date = isnull(@wo_date,m.wko_mst_org_date),@wo_clo_date = d.wko_det_clo_date
from wko_mst m (nolock) join wko_det d (NOLOCK)
on m.RowID = d.mst_RowID
and m.wko_mst_wo_no = @wo_no
join wkr_mst w on w.wkr_mst_wr_no  = d.wko_det_wr_no

if @wr_date >  @cmpl_date
begin 
RAISERROR('Completion date should be greater than work request date',16,1);RETURN
END
if @wr_date >  @response_date
begin 
RAISERROR('Response date should be greater than work request date',16,1);RETURN
END
if @wr_date >  @wo_ack_date
begin 
RAISERROR('Acknowledge date should be greater than work request date',16,1);RETURN
END
if @wo_ack_date > @response_date
BEGIN
SELECT @response_date '@response_date',@wo_ack_date '@wo_ack_date'
RAISERROR('Response date should be greater than Acknowledge date',16,1);RETURN
END
if (@response_date > @cmpl_date) or (@wo_ack_date > @cmpl_date)
BEGIN
SELECT @response_date '@response_date',@cmpl_date '@cmpl_date',@wo_ack_date '@wo_ack_date'
RAISERROR('Completion date should be greater than Response date and Acknowledge date ',16,1);RETURN
END

if (@wo_date > @ack_date) or (@wo_date > @response_date) or (@wo_date > @cmpl_date)
begin 

SELECT @response_date '@response_date',@cmpl_date '@cmpl_date',@wo_ack_date '@wo_ack_date',@wo_date '@wo_date'
RAISERROR('Work order date should be less than   Response date and Acknowledge date and completion date ',16,1);RETURN
END

if @wo_clo_date < @cmpl_date
BEGIN

SELECT @response_date '@response_date',@cmpl_date '@cmpl_date',@wo_ack_date '@wo_ack_date',@wo_date '@wo_date'
RAISERROR('completion date should be less than   close date',16,1);RETURN
end 

update d 
set d.wko_det_cmpl_date = isnull(@cmpl_date,d.wko_det_cmpl_date)
,d.wko_det_exc_date = isnull( @response_date,d.wko_det_exc_date)
,d.wko_det_sched_date = isnull(@wo_ack_date,d.wko_det_sched_date)
from	wko_mst m (NOLOCK)
JOIN	wko_det d (NOLOCK)
on m.RowID =d.mst_RowID
and m.wko_mst_wo_no = @wo_no

update wko_mst
set wko_mst_org_date = isnull(@wo_date,wko_mst_org_date)
where wko_mst_wo_no = @wo_no

 
end