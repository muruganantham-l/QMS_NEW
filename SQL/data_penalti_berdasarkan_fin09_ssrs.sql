alter proc data_penalti_berdasarkan_fin09_ssrs
@year_from   int = 2018
,@year_to int = 2018
,@quarter varchar(10) = 'q1'
 ,@clinic_category  varchar(300) = null
as
begin
set NOCOUNT ON

IF @quarter IN ('ALL','0')
begin
select @quarter = null
end

IF @clinic_category IN ('ALL','1')
begin
select @clinic_category = null
end

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

SELECT DISTINCT year_from,ast_loc_state from all_year,ast_loc
 

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
and (quarter1= @quarter or @quarter is null)
and (t.clinic_category = @clinic_category or @clinic_category is null)
--where t.state1 = @state
--and t.year1 = @year

--SELECT * from  ast_loc

set nocount OFF

end
 
--select * from    data_penalti_berdasarkan_fin09_tbl where    quarter1 = 'q1'  and year1 = 2018




