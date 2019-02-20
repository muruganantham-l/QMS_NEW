alter proc data_penalti_berdasarkan_fin09_sp
 @state							varchar(300)	= null	
,@year						varchar(300)	= null
,@response_time						varchar(300)	= null
,@repair_time				varchar(300)	= null
,@schedule_maintenance				varchar(300)	= null
,@uptime_guarantees				varchar(300)	= null
 ,@ctxt_user			 varchar(300) = null
 ,@quarter varchar(10) = null
 ,@clinic_category  varchar(300) = null
as 
begin

set nocount on
declare @sysdate datetime = getdate()

--drop table test
--SELECT @state 'state',@YEAR 'year' into test

if  @state = '--Select--'
begin
raiserror('Please choose state',16,1);return
end

if  @YEAR = '--Select--'
begin
raiserror('Please choose year',16,1);return
end 

if @quarter in ('--Select--','0')
begin
raiserror('Please choose quarter',16,1);return
end 


if @clinic_category in ('--Select--','0')
begin
raiserror('Please choose quarter',16,1);return
end 



select @state					= ltrim(rtrim(@state))			
select @year					= ltrim(rtrim(@year))
select @response_time			= ltrim(rtrim(@response_time))
select @repair_time				= ltrim(rtrim(@repair_time))
select @schedule_maintenance	= ltrim(rtrim(@schedule_maintenance))
select @uptime_guarantees		= ltrim(rtrim(@uptime_guarantees))
select @clinic_category			= ltrim(rtrim(@clinic_category))
 
		if exists (select '' from data_penalti_berdasarkan_fin09_tbl (nolock) where state1 = @state and year1 = @year and quarter1 = @quarter and clinic_category = @clinic_category)
		begin

			update data_penalti_berdasarkan_fin09_tbl
			set 
			response_time				= @response_time	
			,repair_time			= @repair_time
			,schedule_maintenance	= @schedule_maintenance
			,uptime_guarantees		= @uptime_guarantees
			,modified_by	 = 	@ctxt_user	
			,modified_date =  @sysdate
			where state1 = @state and year1 = @year and quarter1 = @quarter and clinic_category = @clinic_category

			--alter table data_penalti_berdasarkan_fin09_tbl add clinic_category varchar(100)

		end
		else
		begin
			insert data_penalti_berdasarkan_fin09_tbl
			(
			state1
			,year1
			,response_time
			,repair_time
			,schedule_maintenance
			,uptime_guarantees
			,created_by 
			,created_date
			,quarter1
			,clinic_category
			)


			select 
			 @state				
			,@year			
			,@response_time					
			,@repair_time			
			,@schedule_maintenance				
			,@uptime_guarantees			
			,@ctxt_user
			,@sysdate 	
			,@quarter
			,@clinic_category
		end
 
 

set nocount off
end



