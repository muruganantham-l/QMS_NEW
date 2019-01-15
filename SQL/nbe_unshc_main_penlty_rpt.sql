--exec sp_kpi_penalty_report_out_qms 'all' ,'all' , 'all' , 'all' , '01/09/2017','31/08/2018','all','0x0a','Analyzers, Laboratory, Blood, Hemoglobin'	,'H2'		,'BATCH 4'
--	,'EDARAN MEDICALTECH M SDN BHD'	,'Stanbio Laboratory'	 

ALTER proc nbe_unshc_main_penlty_rpt
 @be_category		varchar(200)		= null
,@war_start_date	varchar(200)	 = null--'2017-12-01 00:00:00.000'
,@war_end_date      	varchar(200)	= null-- '2018-11-30 00:00:00.000'
,@manufacture		varchar(200)		= null
,@model				varchar(200)	= null		 
,@batch				varchar(200)		= 'batch 5'
,@supp_name				varchar(200)	= null
,@ownership			varchar(200) = null
,@checkbox varchar(200) ='true'

as
begin
set nocount ON

/************declaration section start******************/
declare @sysdate date = getdate()


--select 
--@be_category			'@be_category'	
--,@war_start_date	 '@war_start_date'
--,@war_end_date   '@war_end_date'   
--,@manufacture	'@manufacture'	
--,@model		'@model'		
--,@batch		'@batch'		
--,@supp_name		'@supp_name'	
--,@ownership		'@ownership'	

--into test

--drop table test




declare @startdate date =  convert(varchar(10), convert(date, @war_start_date, 103), 120)
		,@enddate  date =   convert(varchar(10), convert(date, @war_end_date, 103), 120) 

declare  
@getdate		varchar(30) =  convert(varchar(30), @sysdate,103)
,@guid			varchar(100) = '0x0a' --newid()
 
Declare @startdate_temp Datetime
Declare @enddate_temp Datetime

if @startdate_temp is null 
begin 

SELECT @startdate_temp = min(ast_det_datetime1)
,@enddate_temp = max(ast_det_warranty_date) 
from ast_det (nolock) where ast_det_varchar21 = @batch

end
 
--create table parent_be_number_list 
--(
--be_number  varchar(30)
--)
--declare all_be_number_list table
--(
--be_number  varchar(30)
--,be_category varchar(300)
--,manufacturer  varchar(300)
--,model  varchar(300)
 
--,clinic_type varchar(20)
--,rowid numeric(12,0)
--,clinic_name varchar(300)
--,state1		varchar(300)
--,district varchar(300)
--,be_group nvarchar(8)
--,asset_cost  numeric(28,2)
--,zone varchar(300)
--,circle varchar(300)
--,[Ownership] varchar(300)
--,ageofbe int
--,supplier_name  varchar(300)
--)

/*************declaration section end********************/
if @ownership in  ('ALL','0') or @ownership is null
begin
set @ownership   = '%'
end

 
if @manufacture='all'
begin
select @manufacture = null
end

if @model = 'all'
BEGIN
SELECT @model = null
END

if @be_category = 'all'
BEGIN
SELECT @be_category = null
END
 
DELETE parent_be_number_list
insert parent_be_number_list (be_number)
select m.ast_mst_asset_no
from ast_mst m (NOLOCK) 
join ast_det d (NOLOCK)
on   m.RowID = d.mst_RowID
--and m.ast_mst_asset_no = 'jhr005935'
 
where --ast_det_varchar15= 'Existing'
      (d.ast_det_varchar16 = @supp_name				or @supp_name is null)
and   (d.ast_det_mfg_cd = @manufacture				or @manufacture is null)
and   (d.ast_det_modelno = @model					or @model is null)
and   (m.ast_mst_asset_longdesc  = @be_category		or @be_category is null)
and   d.ast_det_varchar21 = @batch
 
and d.ast_det_varchar15 in (	select Ownership_Type from ownership_mst (nolock) 
										where-- Ownership_desc not in ('Accessories') 
										   Ownership_desc like @ownership
										)
 
 
--SELECT 
--@be_category			'be_category'
--,@war_start_date		'war_start_date'
--,@war_end_date  		'war_end_date' 
--,@manufacture			'manufacture'	
--,@model					'model'			
--,@batch					'batch'			
--,@supp_name				'supp_name'		
--,@ownership				'ownership'
--INTO TEST
 DELETE all_be_number_list

insert all_be_number_list (be_number,be_category,be_group,rowid,zone,circle)
SELECT ast_mst_asset_no,ast_mst_asset_longdesc,ast_mst_asset_type,m.RowID,ast_mst_perm_id,ast_mst_work_area
from   ast_mst m (NOLOCK)
join   parent_be_number_list t 
on     m.ast_mst_asset_no LIKE t.be_number+'%'
--on m.ast_mst_parent_id = t.be_number-- dont use this condition

update  a
set     a.clinic_type = c.cus_mst_fob
,a.clinic_name = c.cus_mst_desc
,state1 = e.cus_det_state
,district = e.cus_det_city
,asset_cost = d.ast_det_asset_cost
,[Ownership] = ast_det_varchar15
,ageofbe = CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, d.ast_det_purchase_date, @sysdate) AS DECIMAL(12, 5)) / 365, 16))
,manufacturer = ast_det_mfg_cd
,model = d.ast_det_modelno
 ,supplier_name = d.ast_det_varchar16
from    all_be_number_list a
join    ast_det d (nolock) on a.rowid = d.mst_RowID
join    cus_mst c (nolock) on c.cus_mst_customer_cd = d.ast_det_cus_code
join    cus_det e on c.RowID = e.mst_RowID

--cus_mst
--alter TABLE nbe_unshc_main_penlty_tbl add asset_cost numeric(28,2)

--select @startdate_temp = @startdate


--WHILE ( @startdate_temp BETWEEN @startdate AND  @enddate )

--BEGIN
 
--select @enddate_temp = CONVERT(datetime,DATEADD(SS,-1,Dateadd(mm,1,@startdate_temp)))

/*
insert nbe_unshc_main_penlty_tbl (
 be_number
,be_category
,Begroup
,asset_cost
,clinic_type
,wr_number
--,wo_number
,wr_datetime
/*
,final_response_days
,final_repair_days
,final_response_penalty_cost
,final_repair_penalty_cost
,final_total_penalty_cost
*/
,clinic_name
,state1
,district
,guid
,wr_rowid
)
*/

--alter TABLE Tsd_penalty_report_tab_tmp add wo_rowid NUMERIC(9)

insert into Tsd_penalty_report_tab_tmp
(GUID
,[Asset_no]
,[BE_Category]
,[BeGroup]
,[Asset_Cost]
,[ClinicType]
,[WR Number]
,[Wr Datetime]
,[clinic_name]
,[State]
,[District]
,wr_rowid
,[Zone]
,[Circle]
,ast_rowid
,[Ownership]
,[WR Status]
,[WR Month]
,[Response KPI]
,[Repair KPI]
,AgeofBE
,ast_det_mfg_cd
,ast_det_modelno
,supp_name
 
/*

,[Final Response KPI ExclHoli]
,[Final Repair KPI ExclHoli]
,[MonthStart]
,[MonthEnd]
,[AgeofBE]
,[KPI_Remains]
,[penalty_cost]
,[Repair_penalty_cost]
,[Response_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
,[clinic_code]
,[clinic_category]
,ast_det_varchar21
,ast_det_varchar16
,ast_det_mfg_cd
,ast_mst_asset_longdesc
,wko_mst_type

*/
)

SELECT @guid
,t.be_number as be_number
,t.be_category  as [BE_Category]
,t.be_group as [BeGroup]
,t.asset_cost as asset_cost
,t.clinic_type as [ClinicType]
,m.wkr_mst_wr_no as [WR Number]
,m.wkr_mst_org_date as [Wr Datetime]
,t.clinic_name 
,t.state1
,t.district
,m.rowid as wr_rowid
,t.zone
,t.circle
,t.rowid
,t.[Ownership]
,m.wkr_mst_wr_status
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)  as [WR Month]
,'0' AS 'Response KPI'
,'0' AS 'Repair KPI'
,t.AgeofBE
,t.manufacturer
,t.model
,t.supplier_name
from wkr_mst m (NOLOCK)
join all_be_number_list t
on m.wkr_mst_assetno = t.be_number
and m.wkr_mst_org_date BETWEEN @startdate and @enddate
 AND m.wkr_mst_wr_status in ('A','W')-- <> 'D'
 

update  t
set     t.[WO Number] = d.wkr_det_wo
,[Final Response KPI] = 0
,[Final Repair KPI] = 0
from    Tsd_penalty_report_tab_tmp t
join	wkr_det d (NOLOCK)
on		t.wr_rowid = d.mst_rowid
where   guid = @guid

update t
set    t.[ProblemReported]		= wko_mst_descs
	   ,t.[WO Status]				= wko_mst_status
	   ,t.[WO Date && Time] = m.wko_mst_org_date
	   ,wo_rowid = m.RowID
from   Tsd_penalty_report_tab_tmp t
join   wko_mst m on t.[WO Number] = m.wko_mst_wo_no
and    t.guid = @guid

update t SET
t.[Actiontaken]			= wko_det_corr_action
,t.[Response Date && Time]	= wko_det_exc_date
,t.[Completion Date && Time]		= wko_det_cmpl_date
,t.[Assign To] = d.wko_det_assign_to
,[Employee Name] = d.wko_det_assign_to

from   Tsd_penalty_report_tab_tmp t
join   wko_det d on t.wo_rowid = d.mst_rowid
and    t.guid = @guid

update Tsd_penalty_report_tab_tmp
set    [Response Date && Time] = @sysdate
where  [Response Date && Time] is NULL
and guid = @guid

update Tsd_penalty_report_tab_tmp
set    [Completion Date && Time] = @sysdate
where  [Completion Date && Time] is NULL
and  guid = @guid

update Tsd_penalty_report_tab_tmp SET
[Actual Response KPI] = CEILING(CAST(DATEDIFF(MI,    [Wr Datetime], [Response Date && Time]) AS DECIMAL(12, 5)) / 60 / 24) 
,[Actual Repair KPI] =CEILING(CAST(DateDiff(minute, [Wr Datetime], [Completion Date && Time]) AS DECIMAL(14, 5)) / 60 / 24)
,[Holidays&Weekends]		= dbo.[state_noofholidays]([State], [Wr Datetime],[Response Date && Time])
,[Repair Holidays&Weekends]	= dbo.[state_noofholidays]([State], [Wr Datetime],[Completion Date && Time])
where guid = @guid


update tab
set  [Response KPI]= ResponseDays  , [Repair KPI] = Repairdays
from Tsd_penalty_report_tab_tmp tab (nolock),
	KPI_Day_mst mst (nolock)
where  [Guid] = @guid
and Asset_type = Begroup
and mst.ClinicType = tab.ClinicType


--if suser_name() = 'tommsadm'
--begin

--select * from Tsd_penalty_report_tab_tmp tab (nolock),
--	KPI_Day_mst mst (nolock)
--where  [Guid] = @guid
--and Asset_type = Begroup
--and mst.ClinicType = tab.ClinicType

 
--   select Begroup,ClinicType from  Tsd_penalty_report_tab_tmp
--end
/*

select  * from Tsd_penalty_report_tab tab (nolock),
	KPI_Day_mst mst (nolock)
where  [Guid] = @guid
and Asset_type = Begroup
and mst.ClinicType = tab.ClinicType
*/

update Tsd_penalty_report_tab_tmp
set [Final Response KPI] = [Actual Response KPI],
	[Final Repair KPI] = [Actual Repair KPI]
where  [Guid] = @guid


update Tsd_penalty_report_tab_tmp
set [Final Response KPI] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime],  [Response Date && Time]) AS DECIMAL(12, 5)) / 60 / 24)
where   [Response Date && Time] >= @sysdate
and  [Guid] = @guid



update Tsd_penalty_report_tab_tmp
set [Final Repair KPI] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], [Completion Date && Time]) AS DECIMAL(12, 5)) / 60 / 24)
where    [Completion Date && Time]  >= @sysdate
and  [Guid] = @guid
--SELECT @startdate_temp = cONVERT(datetime,DATEADD(mm,1,CONVERT(DATETIME,@startdate_temp)))
--END

update Tsd_penalty_report_tab_tmp
set [Holidays&Weekends] = dbo.[state_noofholidays](State,[Wr Datetime], [Response Date && Time] ) 
where    [Response Date && Time]  >= @sysdate
and  [Guid] = @guid


update Tsd_penalty_report_tab_tmp
set [Repair Holidays&Weekends] = dbo.[state_noofholidays](State,[Wr Datetime], [Completion Date && Time])
where   [Completion Date && Time] >= @sysdate
and  [Guid] = @guid


 
update Tsd_penalty_report_tab_tmp
set [Final Response KPI ExclHoli] = [Final Response KPI]-[Holidays&Weekends]-[Response KPI]
Where  [Guid] = @guid


update Tsd_penalty_report_tab_tmp
set [Final Repair KPI ExclHoli] = [Final Repair KPI] - [Repair Holidays&Weekends] - [Repair KPI]
Where  [Guid] = @guid


update Tsd_penalty_report_tab_tmp
set [Final Response KPI ExclHoli] = 0
Where  [Guid] = @guid
and [Final Response KPI ExclHoli] <=0


update Tsd_penalty_report_tab_tmp
set [Final Repair KPI ExclHoli] = 0
Where  [Guid] = @guid
and [Final Repair KPI ExclHoli] <=0


update tab
set penalty_cost = cost.penalty_cost ,
	Repair_penalty_cost = cost.penalty_cost * [Final Repair KPI ExclHoli] ,
	Response_penalty_cost =  iif([Final Response KPI ExclHoli] > [Response KPI],cost.penalty_cost,0),
	--Response_penalty_cost = cost.penalty_cost * [Final Response KPI ExclHoli] ,
	Total_penalty_cost = isnull((cost.penalty_cost * [Final Repair KPI ExclHoli] ),0.0)+isnull(iif([Final Response KPI ExclHoli] > [Response KPI],cost.penalty_cost,0),0.0)
from 
Tsd_penalty_report_tab_tmp tab(nolock),
Pen_cost_mst cost (nolock)
WHERE [Guid] = @guid
and Asset_Cost between costfrom and isnull(costto,Asset_Cost)

 

update Tsd_penalty_report_tab_tmp
set Total_penalty_cost = 0.0 , Remarks = 'BE Age > 15 Years'
Where  [Guid] = @guid
and AgeofBE  >=16

  

--alter table nbe_unshc_main_penlty_tbl add wr_rowid numeric(12)


--update Tsd_penalty_report_tab_tmp
--set [Final Response KPI ExclHoli] = [Final Response KPI]-[Holidays&Weekends]-[Response KPI]
--Where  [Guid] = @guid
--alter table Tsd_penalty_report_tab_tmp add   supp_name varchar(500)
 
SELECT
supp_name 'supplier_name'
,BE_Category 'be_category'
,ast_det_mfg_cd 'manufacture'
,ast_det_modelno 'model'
,format(@sysdate, 'dd/MM/yyyy') 'date'
--,iif(@ownership   = '%','ALL',Ownership) 'ownership'
,Ownership 'ownership'
,@batch 'batch'
,concat(format(@startdate, 'dd/MM/yyyy') ,SPACE(5),'to' ,SPACE(5), format(@enddate, 'dd/MM/yyyy') ) 'period'
,Asset_no 'be_number'
,BE_Category 'BE_Category'
,ProblemReported 'ProblemReported'
,Actiontaken 'Actiontaken'
,[WO Status] 'wo_status'
,[WR Number] 'wr_number'
,format([Wr Datetime] ,'dd/MM/yyyy hh:mm:ss') 'wr_datetime'
,format([Response Date && Time] ,'dd/MM/yyyy hh:mm:ss')   'response_datetime'
,format([Completion Date && Time] ,'dd/MM/yyyy hh:mm:ss') 'completion_datetime'
, [Response KPI] /*[Actual Response KPI]*/  'kpi_days_response'
,[Repair KPI] /*[Actual Repair KPI]*/ 'kpi_days_repair'
,penalty_cost 'per_day_penalty_cost'
,[Final Response KPI ExclHoli] 'Final_Response_KPI_ExclHoli'
,[Final Repair KPI ExclHoli] 'Final_Repair_KPI_ExclHoli'
,Response_penalty_cost 'final_response_penalty_cost'
,Repair_penalty_cost 'final_repair_penalty_cost'

,Total_penalty_cost 'final_Total_penalty_cost'
,clinic_name 'clinic_name'
,[State] 'State'
,[District] 'District'
 
from   Tsd_penalty_report_tab_tmp (nolock)
where [Guid] = @guid

delete  Tsd_penalty_report_tab_tmp  
where [Guid] = @guid


 -- select format(getdate(),'dd/MM/yyyy hh:mm:ss')
set nocount OFF
end




