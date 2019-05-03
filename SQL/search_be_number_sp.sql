alter proc search_be_number_sp
 @state					varchar(300) = 'SABAH'
,@district				varchar(300) = 'ALL'
,@clinic_category		 varchar(300) = 'ALL'
,@clinic_code			varchar(300) = 'ALL'
,@install_year			varchar(300) = '2019'
,@install_month			varchar(300) = '3'
,@batch					varchar(300) = null
as
begin
set nocount ON
--select
-- @state				state				
--,@district			district			
--,@clinic_category	clinic_category	
--,@clinic_code		clinic_code		
--,@install_year		install_year		
--,@install_month		install_month		
--into test

if @district = 'all' SELECT @district = null
if @clinic_code = 'all' SELECT @clinic_code = null
if @clinic_category = 'all' SELECT @clinic_category = null
if isnull(@batch,'') = '' SELECT @batch = null

--drop table test

declare @install_date date = concat(@install_year,'-',@install_month,'-','01')

select m.ast_mst_asset_no 'be_number' from ast_mst m (NOLOCK) join ast_det d (NOLOCK)
on m.RowID = d.mst_RowID
and m.ast_mst_ast_lvl = @state
and (m.ast_mst_asset_locn = @district or @district is null)
and (m.ast_mst_asset_code = @clinic_category or @clinic_category is null)
and (d.ast_det_cus_code = @clinic_code or @clinic_code is null)
and @install_date BETWEEN ast_det_datetime3 and ast_det_datetime4
and ast_det_varchar15 = 'New Biomedical'
and (ast_det_varchar21 = @batch or @batch is null)
 

set NOCOUNT OFF
end

