ALTER  proc sm_penalty_monthly_report_sp
 --@month_year			date			= '2018-11-16'
 @month 					varchar(30) = '1'
 ,@year 					varchar(30) = '2019'
,@clinic_code			varchar(250)	= null
,@clinic_name			varchar(250)	= 'all'
,@clinic_category		varchar(250)	= 'all'-- '1'
,@district				varchar(250)	= 'PULAU PINANG'
,@state					varchar(250)	= 'JOHOR'
as
begin
set nocount on

declare @month_year date = concat(@year,'-',@month,'-','01')

declare @guid			varchar(300) = newid()
		,@start_date	date = DATEADD(MONTH, DATEDIFF(MONTH, 0, @month_year) , 0) 
		,@end_date		date = DATEADD(SECOND, -1, DATEADD(MONTH, 1,  DATEADD(MONTH, DATEDIFF(MONTH, 0, @month_year) , 0) ) ) 
		,@month_name	varchar(300) = datename(month,@month_year)
		--,@year			int	=	year(@month_year) 

     

--drop table test
if @clinic_code in ( 'all','')
select @clinic_code = null

if @clinic_category = 'all'
select @clinic_category = null

if @state = 'all'
SELECT @state = null

if @district = 'All'
SELECT @district = NULL
--alter table sm_penalty_monthly_report_tbl add purchase_cost numeric(21,4)
--drop table test

--SELECT  c.cus_mst_desc
--from    cus_mst c (NOLOCK)

--select	 @month_year		'@month_year'
--		,@clinic_code	 '@clinic_code'	
--		,@clinic_name		 '@clinic_name'
--		,@clinic_category	'@clinic_category'
--		,@district			'@district'
--		,@state		 '@state'	
--		,@start_date '@start_date'
--		,@end_date 'enddate'	
--		,@month 'month'
--		,@year 'year'
--		into test 

		--drop table test

insert sm_penalty_monthly_report_tbl
(
wo_number
,wo_start_datetime
,wo_cmpl_datetime
,be_number
,be_group
,no
,session_id
--,clinic_name
,clinic_category
,district
,state
,month_year
,clinic_code
,status
,vcm_proposed_amount
,remarks
)
select	m.wko_mst_wo_no
		,m.wko_mst_org_date
		,d.wko_det_cmpl_date
		,m.wko_mst_assetno
		,m.wko_mst_asset_group_code
		,ROW_NUMBER() over(order by  m.wko_mst_assetno,m.wko_mst_wo_no)
		,@guid
	--	,@clinic_name
		,wko_det_varchar2 clinic_category
		,m.wko_mst_asset_location district
		,wko_mst_asset_level
		,CONCAT(@month_name,' / ',@year) as month_year
		,wko_det_customer_cd
		,'CURRENT'--CASE   when  wko_mst_status = 'OPE' then 'CURRENT-OPEN' when wko_mst_status IN ('CMP','CLO') then 'CURRENT-CLOSED' else null END
		,null--commented by murugan DATEDIFF(mm,isnull(IIF(d.wko_det_cmpl_date>@end_date,NULL,d.wko_det_cmpl_date),m.wko_mst_org_date),@end_date)+1
		--2018-12-12 30
		,case when d.wko_det_datetime1 is not null and d.wko_det_cmpl_date is null then 'Reschedule SM WO on '+FORMAT(d.wko_det_datetime1,'dd/MM/yyyy') else null END remarks
from	wko_mst m (nolock)
join	wko_det	d (nolock)
on      m.rowid = d.mst_rowid
where   cast( isnull(d.wko_det_datetime1,m.wko_mst_org_date) as DATE) between @start_date and @end_date
AND		(d.wko_det_customer_cd = @clinic_code or @clinic_code is null)
AND		(d.wko_det_varchar2 = @clinic_category or @clinic_category is null)
and     left(m.wko_mst_wo_no,3) = 'pwo'
and     (m.wko_mst_asset_level = @state or @state is null)
and     (m.wko_mst_asset_location   = @district or @district is null) 
UNION

select	m.wko_mst_wo_no
		,m.wko_mst_org_date
		,d.wko_det_cmpl_date
		,m.wko_mst_assetno
		,m.wko_mst_asset_group_code
		,ROW_NUMBER() over(order by  m.wko_mst_assetno,m.wko_mst_wo_no)
		,@guid
	--	,@clinic_name
		,wko_det_varchar2 clinic_category
		,wko_mst_asset_location district
		,wko_mst_asset_level
		,CONCAT(@month_name,' / ',@year) as month_year
		,wko_det_customer_cd
		,'PREVIOUS-OPEN' wko_mst_status
		,1--commented by murugan DATEDIFF(mm,m.wko_mst_org_date,@end_date)+1
		,case when d.wko_det_datetime1 is not null and d.wko_det_cmpl_date is null then 'Reschedule SM WO on '+FORMAT(d.wko_det_datetime1,'dd/MM/yyyy') else null END remarks
from	wko_mst m (nolock)
join	wko_det	d (nolock)
on      m.rowid = d.mst_rowid
where   cast( isnull(d.wko_det_datetime1,m.wko_mst_org_date) as DATE) < @start_date
AND		(d.wko_det_customer_cd = @clinic_code or @clinic_code is null)
AND		(d.wko_det_varchar2 = @clinic_category or @clinic_category is null)
and     left(m.wko_mst_wo_no,3) = 'pwo'
and		m.wko_mst_status = 'ope'
and     (m.wko_mst_asset_level = @state or @state is null)
and     (m.wko_mst_asset_location   = @district or @district is null)

update t
set clinic_name = m.cus_mst_desc
from sm_penalty_monthly_report_tbl t
join cus_mst m (nolock) on t.clinic_code = m.cus_mst_customer_cd
and session_id = @guid

update sm_penalty_monthly_report_tbl
set wo_cmpl_datetime = NULL
where wo_cmpl_datetime > @end_date

update sm_penalty_monthly_report_tbl
set status =  'CURRENT-OPEN'
where wo_cmpl_datetime is NULL
AND status = 'CURRENT'


update sm_penalty_monthly_report_tbl
set status =  'CURRENT-CLOSED'
,vcm_proposed_amount = NULL
where wo_cmpl_datetime is NOT NULL
AND status = 'CURRENT'

update t
set be_category			= a.ast_mst_asset_longdesc
	,equipment_cost		= ad.ast_det_asset_cost
	,sm_type			= ad.ast_det_varchar10
	--,purchase_cost =ast_det_asset_cost
from  sm_penalty_monthly_report_tbl t (nolock)
JOIN	ast_mst a (NOLOCK)
on a.ast_mst_asset_no = t.be_number
join	ast_det ad (nolock)
on a.RowID = ad.mst_RowID
and session_id = @guid

update t 
set t.sm_penalty_rate_month = delayed_ppm_time_penalty_month
 ,t.vcm_proposed_amount = vcm_proposed_amount * delayed_ppm_time_penalty_month
 --commented by murugan vcm_proposed_amount * delayed_ppm_time_penalty_month
from  sm_penalty_monthly_report_tbl t (nolock)
join  uptime_kpi_penalt_mst u (NOLOCK)
on t.equipment_cost BETWEEN u.purchase_val_from and isnull(u.purchase_value_to,t.equipment_cost)

 

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
,vcm_proposed_amount	  vcm_proposed_amount
,disputed			  disputed	
,vcm_agreed_amount	 	 vcm_agreed_amount
,isnull(status		,'')	status		
,isnull(remarks,'') remarks
,clinic_code				
from sm_penalty_monthly_report_tbl (nolock)
 
where session_id = @guid

DELETE sm_penalty_monthly_report_tbl where session_id = @guid

set nocount off
end
 
--alter TABLE sm_penalty_monthly_report_tbl add sm_penalty_value NUMERIC(28,2)

--select * from  cus_mst m where m.cus_mst_customer_cd='PNG500'











