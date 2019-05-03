ALTER proc vcm_report_data_add_sp
@state							varchar(300)	= null	
,@district						varchar(300)	= null	
,@year							varchar(300)	= null
,@quarter						varchar(10)		= null
,@clinic_category				varchar(300)	= null
,@response_time					varchar(300)	= null
,@repair_time					varchar(300)	= null
,@schedule_maintenance			varchar(300)	= null
,@ctxt_user						varchar(300)	= null
as
begin
set NOCOUNT ON

declare @sysdate datetime = getdate()

if  @state = '--Select--'
begin
raiserror('Please choose state',16,1);return
end


if  @district = '--Select--'
begin
raiserror('Please choose District',16,1);return
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
raiserror('Please choose Clinic category',16,1);return
end 



select @state					= ltrim(rtrim(@state))			
select @year					= ltrim(rtrim(@year))
select @response_time			= ltrim(rtrim(@response_time))
select @repair_time				= ltrim(rtrim(@repair_time))
select @schedule_maintenance	= ltrim(rtrim(@schedule_maintenance))
select @clinic_category			= ltrim(rtrim(@clinic_category))



	if exists (select '' from data_vcm_report_tbl (nolock) 
				where state1 = @state and district = @district 
				and year1 = @year and quarter1 = @quarter and clinic_category = @clinic_category)
		begin

			update data_vcm_report_tbl
			set 
			response_time				= @response_time	
			,repair_time			= @repair_time
			,schedule_maintenance	= @schedule_maintenance
			,modified_by	 = 	@ctxt_user	
			,modified_date =  @sysdate
			 ,validate_flag	=	'N'	
			where state1 = @state and district = @district and year1 = @year and quarter1 = @quarter and clinic_category = @clinic_category

			--alter table data_vcm_report_tbl add clinic_category varchar(100)

		end
		else
		begin

			insert data_vcm_report_tbl
			(
			state1
			,district
			,year1
			,response_time
			,repair_time
			,schedule_maintenance
		 	,created_by 
			,created_date
			,quarter1
			,clinic_category
			,validate_flag			
			,updated_flag
			)


			select 
			 @state		
			 ,@district		
			,@year			
			,@response_time					
			,@repair_time			
			,@schedule_maintenance				
		 	,@ctxt_user
			,@sysdate 	
			,@quarter
			,@clinic_category
			,'N'
			,'N'
		end
 

set NOCOUNT OFF
end