alter PROCEDURE  curd_NBE_bill_sp
  @Action						VARCHAR(10) = 'SELECT'
 ,@rowid										varchar(300)=null
 ,@state								varchar(300)=null
 ,@district						varchar(300)=null
 ,@clinic_category						varchar(300)=null
 ,@clinic_code					varchar(300)=null
 ,@installment_year					varchar(300)=null
 ,@installment_month					varchar(300)= null
 ,@be_number					varchar(300)= null
 ,@batch						varchar(300)= null
 ,@paid_flag					varchar(300)= 'true'
 ,@audit_user					varchar(300)= null
AS
BEGIN
  --select 
	 -- @rowid								rowid								
	 --,@clinic_category					clinic_category					
	 --,@district			 district			
	 --,@clinic_code				clinic_code				
	 --,@installment_year	 installment_year
	 --,@installment_month					 	installment_month					 
	 --,@state					 		state	
	 --,@Action							Action	
	 --,@be_number			  be_number
	 --into  test

	 --drop table test
if @district = 'all' SELECT @district = null
if @clinic_code = 'all' SELECT @clinic_code = null
if @clinic_category = 'all' SELECT @clinic_category = null
if isnull(@be_number,'') = '' SELECT @be_number = null
if isnull(@batch,'') = '' SELECT @batch = null


declare @install_date date = concat(@installment_year,'-',@installment_month,'-','01')

if @Action = 'select'
BEGIN
truncate table nbe_bill_rpt_tmp_tbl

insert nbe_bill_rpt_tmp_tbl
(

rowid				
,s_no				
,be_number			
,batch				
,install_start_date	
,install_end_date	
,curr_install_no	
,modified_by		
,modified_date		
,curr_install_status1
)

select
null	'rowid'              
,ROW_NUMBER() over(order by  ast_det_datetime3,m.ast_mst_asset_no)	's_no'               
,m.ast_mst_asset_no	'be_number'          
,ast_det_varchar21 'batch'              
,concat(left(datename(month,d.ast_det_datetime3),3),'-',right(year(d.ast_det_datetime3),2))  		'install_start_date' 
,concat(left(datename(month,d.ast_det_datetime4),3),'-',right(year(d.ast_det_datetime4),2))  		'install_end_date'   
,datediff(mm,ast_det_datetime3,@install_date)+1 		'curr_install_no'    
          
,null	'modified_by'               
,null	'modified_date'
,null 'curr_install_status1'

from ast_mst m (NOLOCK)
join ast_det d (NOLOCK)
on m.rowid = d.mst_rowid
join ast_aud a (NOLOCK)
on a.mst_RowID = m.RowID
and a.site_cd = m.site_cd
and a.ast_aud_status = 'act'
and @install_date between a.ast_aud_start_date and isnull(a.ast_aud_end_date,@install_date)
--left join nbe_bill_dtl_tbl t (NOLOCK)
--on t.ast_mst_asset_no = m.ast_mst_asset_no
--and installment_date = @install_date
WHERE (m.ast_mst_asset_no = @be_number or @be_number is null)
and m.ast_mst_ast_lvl = @state
and (m.ast_mst_asset_locn = @district or @district is null)
and (m.ast_mst_asset_code = @clinic_category or @clinic_category is null)
and (d.ast_det_cus_code = @clinic_code or @clinic_code is null)
and @install_date BETWEEN ast_det_datetime3 and ast_det_datetime4
and ast_det_varchar15 = 'New Biomedical'
and (ast_det_varchar21 = @batch or @batch is null)
and m.site_cd = 'qms'
--order by ast_det_datetime3


update a
set    a.rowid = t.rowid
,curr_install_status1 = isnull(paid_flag,'false')
,modified_by = t.audit_user	               
,modified_date = t.audit_date	

from   nbe_bill_rpt_tmp_tbl a
join nbe_bill_dtl_tbl t (NOLOCK)
on t.ast_mst_asset_no = a.be_number
and installment_date = @install_date

SELECT * from nbe_bill_rpt_tmp_tbl (NOLOCK) order by s_no

END

--drop table nbe_bill_dtl_tbl

--create table nbe_bill_dtl_tbl
--(
--rowid				numeric(12) IDENTITY(1,1)
--,ast_mst_asset_no	VARCHAR(30)
--,installment_date		DATE
--,paid_flag			VARCHAR(10)
--,audit_user			VARCHAR(30)
--,audit_date			datetime
--)
 
  
  --if @Action = 'update'
  --BEGIN

  -- if EXISTS (SELECT '' from nbe_bill_dtl_tbl (NOLOCK) where rowid =   @rowid)
  -- BEGIN
     
	 --update nbe_bill_dtl_tbl
	 --set    paid_flag = @paid_flag,audit_user = @audit_user,audit_date = getdate()
	 --where rowid = @rowid
	 
  -- END
  -- ELSE
  -- BEGIN
  -- insert nbe_bill_dtl_tbl (ast_mst_asset_no,installment_date,paid_flag,audit_user,audit_date)
	 --select @be_number,@install_date,@paid_flag,@audit_user,getdate()

  -- END
  
  --END

  --truncate TABLE nbe_bill_dtl_tbl
/*

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

	*/
END



