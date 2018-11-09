create proc status_pengeluaran_fin09_ssrs
@state varchar(300) = null
,@year   varchar(300) = null
as
begin
set NOCOUNT ON
select 
state1
,year1
,response_time
,repair_time
,schedule_maintenance
,uptime_guarantees
from status_pengeluaran_fin09_tbl (NOLOCK) t
--where t.state1 = @state
--and t.year1 = @year

set nocount OFF

end