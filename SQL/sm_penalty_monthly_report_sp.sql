ALTER proc sm_penalty_monthly_report_sp
@month_year				date
,@clinic_code			varchar(250)
,@clinic_name			varchar(250)
,@clinic_category		varchar(250)
,@district				varchar(250)
,@state					varchar(250)
as
begin
set nocount on

declare @guid			varchar(300) = newid()
		,@start_date	date = DATEADD(MONTH, DATEDIFF(MONTH, 0, @month_year) , 0) 
		,@end_date		date = DATEADD(SECOND, -1, DATEADD(MONTH, 1,  DATEADD(MONTH, DATEDIFF(MONTH, 0, @month_year) , 0) ) ) 
		,@month			varchar(300) = datename(month,@month_year)
		,@year			int	=	year(@month_year) 

insert sm_penalty_monthly_report_tbl
(
wo_number
,wo_start_datetime
,wo_cmpl_datetime
,be_number
,be_group
,no
,session_id
,be_category
,equipment_cost
,sm_type
,clinic_name
,clinic_category
,district
,state
,month_year
)
select	m.wko_mst_wo_no
		,d.wko_det_exc_date
		,d.wko_det_cmpl_date
		,m.wko_mst_assetno
		,m.wko_mst_asset_group_code
		,ROW_NUMBER() over(order by  m.wko_mst_assetno,m.wko_mst_wo_no)
		,@guid
		,a.ast_mst_asset_longdesc
		,ad.ast_det_asset_cost
		,ad.ast_det_varchar10
		,@clinic_name
		,@clinic_category
		,@district
		,@state
		,CONCAT(@month,'/',@year)
from	wko_mst m (nolock)
join	wko_det	d (nolock)
on      m.rowid = d.mst_rowid
JOIN	ast_mst a (NOLOCK)
on a.ast_mst_asset_no = m.wko_mst_assetno
join	ast_det ad (nolock)
on a.RowID = ad.mst_RowID
where   cast( m.wko_mst_org_date as DATE) between @start_date and @end_date
AND		d.wko_det_customer_cd = @clinic_code
AND		d.wko_det_varchar2 = @clinic_category

--SELECT @start_date 'start_date',@end_date 'end_date',@clinic_code 'clinic_code',@clinic_category 'clinic_category'
--into test
--drop TABLE test
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

--DELETE sm_penalty_monthly_report_tbl where session_id = @guid

set nocount off
end



