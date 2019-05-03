CREATE PROCEDURE [dbo].curd_vcm_value_for_penalty_sp
     @validate_flag		varchar(20) = 'N'

 ,@Action VARCHAR(10) = 'SELECT'
  
 ,@s_no										varchar(300)=null
 ,@clinic_category								varchar(300)=null
 ,@response_time_penalty						varchar(300)=null
 ,@repair_time_penalty						varchar(300)=null
 ,@Preventive_Maintenance_Penalty					varchar(300)=null
  
 ,@validated_by					varchar(300)=null
  ,@state					varchar(300)= 'PULAU PINANG'

AS
BEGIN
      SET NOCOUNT ON;
	  --raiserror('test',16,1);return
	  --select @validate_flag 'validate_flag' into test
	 
	
	 -- select 
	 -- @s_no								s_no								
	 --,@clinic_category					clinic_category					
	 --,@response_time_penalty			response_time_penalty			
	 --,@repair_time_penalty				repair_time_penalty				
	 --,@Preventive_Maintenance_Penalty	Preventive_Maintenance_Penalty
	 --,@validated_by					 	validated_by					 
	 --,@state					 		state	
	 --,@Action							Action				 
	 --into  test

	 --alter table  data_vcm_report_tbl add   validate_flag  varchar(10)
	  --drop table test
 declare @sysdate datetime = getdate()
      --SELECT
	  --data_vcm_report_tbl
	select  @s_no					= rtrim(ltrim(@s_no))
	select  @clinic_category				= rtrim(ltrim(@clinic_category))
	select  @response_time_penalty						= rtrim(ltrim(@response_time_penalty))
	select  @repair_time_penalty				= rtrim(ltrim(@repair_time_penalty))
	select  @Preventive_Maintenance_Penalty					= rtrim(ltrim(@Preventive_Maintenance_Penalty))
	select  @validated_by				= rtrim(ltrim(@validated_by))
	select  @state	= rtrim(ltrim(@state))

	if @clinic_category		= '' 
		select @clinic_category = null
	if   @response_time_penalty						= ''	
		select @response_time_penalty = null	
	if   @repair_time_penalty				= ''
		select @repair_time_penalty = null
	if   @Preventive_Maintenance_Penalty				= ''
		select @Preventive_Maintenance_Penalty = null
	if   @validated_by				= ''
		select @validated_by = null
	if   @state	= ''
		select @state = null

	   --select @validate_flag 'validate_flag',@updated_flag 'updated_flag' into test 

	  --drop table test

	  if @state = 'all'
	  SELECT @state = null

	

    IF @Action = 'SELECT'
      BEGIN

	   
select 
 rowid s_no
,case clinic_category when  1 then 'ALL' when 2 then 'KESIHATAN' when 3 then 'PERGIGIAN' else null end as clinic_category
,response_time
,repair_time			
,schedule_maintenance					
,0 Total_Penalty			
 
,created_by				
,created_date			
,modified_by			
,modified_date			
,validate_flag			
,updated_flag		
,validated_by	
,validated_date
,row_number() over(order by rowid) row_no
--,existing_mst_fields
from data_vcm_report_tbl (nolock)

--alter table data_vcm_report_tbl add validated_date datetime
 
where  state1 = @state
and    validate_flag =  @validate_flag
		 


		 --PERAK

		-- select ast_mst_asset_locn,* from data_vcm_report_tbl b join ast_mst a on be_number = ast_mst_asset_no

			--drop table test

--alter table data_vcm_report_tbl
----drop column existing_mst_flag
----existing_mst_fields
--add existing_mst_fields varchar(600)
      END
 
      --INSERT
    --IF @Action = 'INSERT'
    --  BEGIN
    --        INSERT INTO Customers(Name, Country)
    --        VALUES (@Name, @Country)
    --  END
 
    --  --UPDATE
    IF @Action = 'UPDATE'
      BEGIN

	  --if exists (select '' from mfg_mst (nolock) a where (mfg_mst_mfg_cd = @clinic_category OR ISNULL(@clinic_category,'') = '') )
	  --begin

	  --if exists (select '' from ast_loc (nolock) a where (ast_loc_ast_loc = @Preventive_Maintenance_Penalty OR ISNULL(@Preventive_Maintenance_Penalty,'') = '') )
	  --begin
	  ----JHNMIX087
	  --select  @s_no				'be_number'	
	  --   ,@clinic_category			    'Manufacture'
	  --   ,@response_time_penalty					'Model'
	  --   ,@repair_time_penalty				'SerialNumber'
	  --   ,@Preventive_Maintenance_Penalty				'BELocation'			
	  --   ,@validated_by				'KEWPA_Number'		
	  --   ,@state  'JKKP_Certificate_Number' into test

---		 drop table test
		
			--SELECT @s_no '@s_no' into test

				UPDATE data_vcm_report_tbl
				SET  
				response_time				= @response_time_penalty 
				,repair_time						=	@repair_time_penalty
				,schedule_maintenance				= @Preventive_Maintenance_Penalty		
				 
				,validated_by				= @validated_by
				,validated_date			= @sysdate
				,validate_flag		   = 'Y'
				WHERE  
				  rowid = @s_no

			 

	 
		--end
		--else
		--begin
		--    raiserror('The BE Location not available in the Asset Location Master',16,1);return;
		--end
		--end
		--else 
		--begin
		-- raiserror('The Manufacturer not available in the Manufacturer Master',16,1);return;
		--end
		 
      END
 
    --  --DELETE
    --IF @Action = 'DELETE'
    --  BEGIN
    --        DELETE FROM Customers
    --        WHERE CustomerId = @CustomerId
    --  END
END










