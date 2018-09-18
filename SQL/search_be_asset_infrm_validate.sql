
--drop table be_asset_information_validate

alter proc search_be_asset_infrm_validate
@validate_flag		varchar(20) = null
,@updated_flag		varchar(20) = null
as
begin

set nocount on
select 
be_number				
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
from be_asset_information_validate (nolock)
--where validate_flag =  @validate_flag
--and updated_flag = @updated_flag


set nocount off
end