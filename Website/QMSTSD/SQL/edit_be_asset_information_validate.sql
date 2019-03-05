--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alter proc edit_be_asset_information_validate
 @be_number					varchar(300)	= null	
,@Manufacture				varchar(300)	= null
,@Model						varchar(300)	= null
,@SerialNumber				varchar(300)	= null
,@BELocation				varchar(300)	= null
,@KEWPA_Number				varchar(300)	= null
,@JKKP_Certificate_Number	varchar(300)	= null
,@ctxt_user					varchar(300)	= null
  
as
begin

set nocount on
declare @sysdate datetime = getdate()

if  isnull(rtrim(ltrim(@be_number)),'') = ''
begin
raiserror('Please enter BE Number',16,1);return
end

if exists (select '' from be_asset_information_validate (nolock) where be_number = @be_number)
begin

update be_asset_information_validate
set Manufacture					= @Manufacture			
,Model							= @Model					
,SerialNumber					= @SerialNumber			
,BELocation						= @BELocation			
,KEWPA_Number					= @KEWPA_Number			
,JKKP_Certificate_Number		= @JKKP_Certificate_Number
 ,validate_flag	=	'N'		
,modified_by	 = 	@ctxt_user	
,modified_date =  @sysdate
where be_number = @be_number

end
else
begin
insert be_asset_information_validate
(
 be_number				
,Manufacture			
,Model					
,SerialNumber			
,BELocation				
,KEWPA_Number			
,JKKP_Certificate_Number
,created_by				
,created_date	 			
,validate_flag			
,updated_flag	
)


select 
 @be_number				
,@Manufacture			
,@Model					
,@SerialNumber			
,@BELocation				
,@KEWPA_Number			
,@JKKP_Certificate_Number
,@ctxt_user				
,@sysdate			 		
,'N'			
,'N'	
end

set nocount off
end

