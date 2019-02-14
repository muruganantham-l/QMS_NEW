ALTER proc wo_date_update
@wo_no varchar(100) = 'CWO198061'
,@cmpl_date datetime =null-- '2019-02-04 10:00:00.000'

,@response_date datetime = '2019-01-31 13:35:00.000'

,@ack_date datetime = '2019-01-31 13:34:00.000'

,@wo_date datetime = null

 
as
begin
 --select cast('29/11/2018 16:30' as datetime)

declare @wr_date datetime
,@wo_ack_date datetime
,@wo_clo_date datetime
,@audit_date datetime = getdate()
,@audit_user varchar(10)= 'tomms'

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
SELECT @wr_date '@wr_date'
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

if EXISTS(
Select '*' from wko_mst (nolock) where wko_mst_wo_no = @wo_no and wko_mst_status = 'ope' )
BEGIN
RAISERROR('WO Order Still Open. We cannot proceed for Update',16,1);RETURN
END

update d 
set d.wko_det_cmpl_date = isnull(@cmpl_date,d.wko_det_cmpl_date)
,d.wko_det_exc_date = isnull( @response_date,d.wko_det_exc_date)
,d.wko_det_sched_date = isnull(@wo_ack_date,d.wko_det_sched_date)
,audit_user = @audit_user
,audit_date = @audit_date
from	wko_mst m (NOLOCK)
JOIN	wko_det d (NOLOCK)
on m.RowID =d.mst_RowID
and m.wko_mst_wo_no = @wo_no

update wko_mst
set wko_mst_org_date = isnull(@wo_date,wko_mst_org_date)
,audit_user = @audit_user
,audit_date = @audit_date
where wko_mst_wo_no = @wo_no

update wko_ls7 
						set wko_ls7_resp_date =@response_date ,wko_ls7_ack_date =@ack_date , audit_user= @audit_user, audit_date= @audit_date
						from wko_mst , wko_ls7 
						where wko_mst.rowid = mst_rowid 
						and wko_mst_wo_no = @wo_no 
					 
						and left(wko_mst_wo_no,3) = 'cwo'

 
end

