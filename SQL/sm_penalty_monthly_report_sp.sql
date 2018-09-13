alter proc sm_penalty_monthly_report_sp
@month_year				date
,@clinic_name			varchar(250)
,@clinic_category		varchar(250)
,@district				varchar(250)
,@state					varchar(250)
as
begin
set nocount on

declare @guid varchar(300) = newid()

select
month_year				
,clinic_name			
,clinic_category		
,district				
,state					
,no						
,be_number				
,be_category			
,be_group				
,equipment_cost			
,sm_type				
,wo_number				
,wo_start_datetime		
,wo_cmpl_datetime		
,sm_penalty_rate_month	
,vcm_proposed_amount	
,disputed				
,vcm_agreed_amount		
,status					
,remarks				
from sm_penalty_monthly_report_tbl (nolock)
where session_id = @guid



set nocount off
end

