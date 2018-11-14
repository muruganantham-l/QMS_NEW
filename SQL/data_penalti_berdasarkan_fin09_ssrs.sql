 ALTER proc data_penalti_berdasarkan_fin09_ssrs
@year_from   int = 2015
,@year_to int = 2018
as
begin
set NOCOUNT ON
declare @all_state TABLE
(
year1 INT
,state_name VARCHAR(300)
)
;with all_year as 
(

SELECT @year_from 'year_from'
union ALL
SELECT year_from + 1
from all_year
where year_from  < @year_to
)
 
insert @all_state (year1,state_name)

SELECT year_from,ast_loc_state from all_year,ast_loc

select 
 a.state_name state1
,a.year1
,response_time
,repair_time
,schedule_maintenance
,uptime_guarantees
from data_penalti_berdasarkan_fin09_tbl (NOLOCK) t
right join @all_state a  
on a.state_name = t.state1
and a.year1 = t.year1
--where t.state1 = @state
--and t.year1 = @year

--SELECT * from  ast_loc

set nocount OFF

end


