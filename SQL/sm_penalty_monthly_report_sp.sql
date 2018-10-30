alter  proc sm_penalty_monthly_report_sp
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
,clinic_name
,clinic_category
,district
,state
,month_year
,clinic_code
)
select	m.wko_mst_wo_no
		,d.wko_det_exc_date
		,d.wko_det_cmpl_date
		,m.wko_mst_assetno
		,m.wko_mst_asset_group_code
		,ROW_NUMBER() over(order by  m.wko_mst_assetno,m.wko_mst_wo_no)
		,@guid
		,@clinic_name
		,@clinic_category
		,@district
		,@state
		,CONCAT(@month,' / ',@year) as month_year
		,wko_det_customer_cd
from	wko_mst m (nolock)
join	wko_det	d (nolock)
on      m.rowid = d.mst_rowid
where   cast( m.wko_mst_org_date as DATE) between @start_date and @end_date
AND		d.wko_det_customer_cd = @clinic_code
AND		d.wko_det_varchar2 = @clinic_category

update t
set clinic_name = m.cus_mst_desc
from sm_penalty_monthly_report_tbl t
join cus_mst m on t.clinic_code = m.cus_mst_customer_cd
and session_id = @guid

update t
set be_category			= a.ast_mst_asset_longdesc
	,equipment_cost		= ad.ast_det_asset_cost
	,sm_type			= ad.ast_det_varchar10
from  sm_penalty_monthly_report_tbl t (nolock)
JOIN	ast_mst a (NOLOCK)
on a.ast_mst_asset_no = t.be_number
join	ast_det ad (nolock)
on a.RowID = ad.mst_RowID
and session_id = @guid



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
,format(wo_start_datetime  ,'dd/MM/yyyy hh:mm:ss')	 as wo_start_datetime
,format(wo_cmpl_datetime   ,'dd/MM/yyyy hh:mm:ss')		 as wo_cmpl_datetime
,sm_penalty_rate_month	
,vcm_proposed_amount	
,disputed				
,vcm_agreed_amount		
,status					
,remarks
,clinic_code				
from sm_penalty_monthly_report_tbl (nolock)
where session_id = @guid

DELETE sm_penalty_monthly_report_tbl where session_id = @guid

set nocount off
end



--select * from  cus_mst m where m.cus_mst_customer_cd='PNG500'


