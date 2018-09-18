
alter PROCEDURE [dbo].curd_be_asset_infrm_validate
     @validate_flag		varchar(20) = null

 ,@Action VARCHAR(10) = 'SELECT'
 ,@s_no int					=null 
 ,@be_number					varchar(300)=null
 ,@Manufacture					varchar(300)=null
 ,@Model						varchar(300)=null
 ,@SerialNumber					varchar(300)=null
 ,@BELocation					varchar(300)=null
 ,@KEWPA_Number					varchar(300)=null
 ,@JKKP_Certificate_Number		varchar(300)=null
 ,@validated_by					varchar(300)=null
  ,@state					varchar(300)=null

AS
BEGIN
      SET NOCOUNT ON;
 declare @sysdate datetime = getdate()
      --SELECT


	select  @Manufacture				= rtrim(ltrim(@Manufacture))
	select  @Model						= rtrim(ltrim(@Model))
	select  @SerialNumber				= rtrim(ltrim(@SerialNumber))
	select  @BELocation					= rtrim(ltrim(@BELocation))
	select  @KEWPA_Number				= rtrim(ltrim(@KEWPA_Number))
	select  @JKKP_Certificate_Number	= rtrim(ltrim(@JKKP_Certificate_Number))

	if @Manufacture		= '' 
		select @Manufacture = null
	if   @Model						= ''	
		select @Model = null	
	if   @SerialNumber				= ''
		select @SerialNumber = null
	if   @BELocation				= ''
		select @BELocation = null
	if   @KEWPA_Number				= ''
		select @KEWPA_Number = null
	if   @JKKP_Certificate_Number	= ''
		select @JKKP_Certificate_Number = null

	   --select @validate_flag 'validate_flag',@updated_flag 'updated_flag' into test 

	  --drop table test

    IF @Action = 'SELECT'
      BEGIN
select 
s_no
,upper(be_number)
,Manufacture			
,Model					
,SerialNumber			
,BELocation				
,KEWPA_Number			
,JKKP_Certificate_Number
,created_by				
,created_date			
,modified_by			
,modified_date			
,validate_flag			
,updated_flag		
,validated_by	
,validated_date
--,existing_mst_fields
from be_asset_information_validate (nolock)
where validate_flag =  @validate_flag
and exists (select ''
			from ast_mst a (nolock)
			where a.ast_mst_asset_no = be_number
			and a.ast_mst_asset_locn = @state--'PERAK'
			
			)


		 --PERAK

		-- select ast_mst_asset_locn,* from be_asset_information_validate b join ast_mst a on be_number = ast_mst_asset_no

			--drop table test

--alter table be_asset_information_validate
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

	  if exists (select '' from mfg_mst (nolock) a where (mfg_mst_mfg_cd = @Manufacture OR ISNULL(@Manufacture,'') = '') )
	  begin

	  if exists (select '' from ast_loc (nolock) a where (ast_loc_ast_loc = @BELocation OR ISNULL(@BELocation,'') = '') )
	  begin



				UPDATE be_asset_information_validate
				SET  
				Manufacture				= @Manufacture 
				,Model						=	@Model
				,SerialNumber				= @SerialNumber		
				,BELocation				=	@BELocation			
				,KEWPA_Number				= @KEWPA_Number		
				,JKKP_Certificate_Number	=	@JKKP_Certificate_Number
				,validated_by				= @validated_by
				,validated_date			= @sysdate
				,validate_flag		   = 'Y'
				WHERE s_no = @s_no
				and be_number = @be_number

				update d
				set     ast_det_mfg_cd = isnull(@Manufacture,ast_det_mfg_cd)
				,ast_det_modelno = isnull(@Model,ast_det_modelno)
				,ast_det_varchar2 = isnull(@SerialNumber,ast_det_varchar2)
				,ast_det_varchar19 = isnull(@BELocation,ast_det_varchar19)
				,ast_det_varchar13 = isnull(@KEWPA_Number,ast_det_varchar13)
				,ast_det_varchar14 = isnull(@JKKP_Certificate_Number,ast_det_varchar14)
				from    ast_mst m (nolock)
				join	ast_det d (nolock)
				on		m.rowid =	d.mst_rowid 
				and     m.ast_mst_asset_no = @be_number

	
		end
		else
		begin
		    raiserror('The BE Location not available in the Asset Location Master',16,1);return;
		end
		end
		else 
		begin
		 raiserror('The Manufacturer not available in the Manufacturer Master',16,1);return;
		end
		 
      END
 
    --  --DELETE
    --IF @Action = 'DELETE'
    --  BEGIN
    --        DELETE FROM Customers
    --        WHERE CustomerId = @CustomerId
    --  END
END

