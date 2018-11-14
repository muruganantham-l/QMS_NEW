ALTER proc equipment_maintanance_status_report_sp
 @be_category		varchar(200)		= 'Electrocardiographs, Multichannel'
,@war_start_date	varchar(200)	 = '01/06/2017'
,@war_end_date      	varchar(200)	= '31/05/2018' 
,@manufacture		varchar(200)		= 'edan'	 
,@model				varchar(200)	= 'se-301'		 
,@batch				varchar(200)		= 'BATCH 3'
,@supp_name				varchar(200)	=  'MALAYSIAN HEALTHCARE SDN BHD'	
,@ownership			varchar(200) = 'all'	 
as
begin
set nocount on
 


declare @sysdate date = getdate()


declare @startdate date =  convert(varchar(10), convert(date, @war_start_date, 103), 120)
		,@enddate  date =   convert(varchar(10), convert(date, @war_end_date, 103), 120) 


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
  
 --DROP TABLE TEST

declare  
@getdate		varchar(30) =  convert(varchar(30), @sysdate,103)
,@guid			varchar(100) = '0x0a' --newid()
,@total_rows	int
,@statename		varchar(200)
,@district		varchar(200)
,@zone			varchar(200)
,@reporttype	varchar(200)
,@periodfrom	varchar(200)
,@periodto		varchar(200)
--,@ownership		varchar(200)
 
--declare @month_end_date date = eomonth(dateadd(mm,3,@start_date))

/******** logic from the procedure start**/

Declare @startdate_temp Datetime
Declare @enddate_temp Datetime
 
declare @parent_be_number_list table
(
be_number  varchar(30)
)
declare @all_be_number_list table
(
be_number  varchar(30)
,be_category varchar(300)
,clinic_type varchar(20)
,rowid numeric(12,0)
,clinic_name varchar(300)
,state1		varchar(300)
,district varchar(300)
,be_group nvarchar(8)
,asset_cost  numeric(28,2)
,zone varchar(300)
,circle varchar(300)
,[Ownership] varchar(300)
,ageofbe int
)

/*************declaration section end********************/
if @ownership in  ('ALL','0')
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


insert @parent_be_number_list (be_number)
select m.ast_mst_asset_no
from ast_mst m (NOLOCK) 
join ast_det d (NOLOCK)
on   m.RowID = d.mst_RowID
--and m.ast_mst_asset_no = 'jhr005935'
 
where 
      (d.ast_det_varchar16 = @supp_name				or @supp_name is null)
and   (d.ast_det_mfg_cd = @manufacture				or @manufacture is null)
and   (d.ast_det_modelno = @model					or @model is null)
and   (m.ast_mst_asset_longdesc  = @be_category		or @be_category is null)
and   d.ast_det_varchar21 = @batch
and d.ast_det_varchar15 in (	select Ownership_Type from ownership_mst (nolock) 
										where-- Ownership_desc not in ('Accessories') 
										   Ownership_desc like @ownership
										)
 
 
  
insert @all_be_number_list (be_number,be_category,be_group,rowid,zone,circle)
SELECT ast_mst_asset_no,ast_mst_asset_longdesc,ast_mst_asset_type,m.RowID,ast_mst_perm_id,ast_mst_work_area
from   ast_mst m (NOLOCK)
join   @parent_be_number_list t 
on     m.ast_mst_asset_no LIKE t.be_number+'%'

update  a
set     a.clinic_type = c.cus_mst_fob
,a.clinic_name = c.cus_mst_desc
,state1 = e.cus_det_state
,district = e.cus_det_city
,asset_cost = d.ast_det_asset_cost
,[Ownership] = ast_det_varchar15
,ageofbe = CEILING(COALESCE(CAST(DATEDIFF(DAYOFYEAR, d.ast_det_purchase_date, @sysdate) AS DECIMAL(12, 5)) / 365, 16))
from    @all_be_number_list a
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
from wkr_mst m (NOLOCK)
join @all_be_number_list t
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
	   ,t.wko_mst_type = m.wko_mst_type
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

 

/******** logic from the procedure end****/


--DECLARE @temp table
--(
--start_date1 date
--,end_date   date
--)

--while (@month_end_date <= @end_date)
--begin

--insert @temp(start_date1,end_date)
--SELECT @start_date,@month_end_date
--if   @month_end_date > @end_date
--select @month_end_date = @end_date

--exec sp_kpi_penalty_report_out_qms 'all' ,'all' , 'all' , 'all' , @start_date,@end_date,'all',@guid,@be_category	,@model	,@batch	,@supp_name	,@manufacture	
 
--SELECT @start_date = dateadd(dd,1,@month_end_date)
--SELECT @month_end_date =  eomonth(dateadd(mm,3,@start_date))

--end


--exec sp_kpi_penalty_report_out_qms 'all' ,'all' , 'all' , 'all' , @start_date,@end_date,'all',@guid,@be_category	,@model	,@batch	,@supp_name	,@manufacture	

 
--exec sp_kpi_penalty_report_out_qms 'all' ,'all' , 'all' , 'all' , '2017-06-01','2018-05-31','all','0x0a','Dental Delivery Units'	,'DCI 4511'	,'BATCH 3'	,'SKYDENTAL MALAYSIA SDN BHD'	,'Dental Components LLC'	

-- select @start_date 'start_date',@end_date  'end_date',@be_category 'be_category'
--alter table Tsd_penalty_report_tab_tmp
--add Capping numeric(30,4) 

--alter table Tsd_penalty_report_tab_tmp
--add guid varchar(100)


--alter table Tsd_penalty_report_tab_tmp
----add ast_det_varchar21 varchar(100)
----add ast_det_varchar16 varchar(100)
----add ast_det_mfg_cd varchar(25)
--add ast_mst_asset_longdesc varchar(100)

-- alter table Tsd_penalty_report_tab_tmp
----add KPI_Remains int 
--add [ClinicType]  varchar(100)

--alter table Tsd_penalty_report_tab_tmp
--add wko_mst_type varchar(10)


--alter table Tsd_penalty_report_tab_tmp
--add [Repair KPI_remains] int


--USE [tomms_prod]
--GO
--CREATE NONCLUSTERED INDEX ix_site_cd
--ON [dbo].[ast_det] ([site_cd],[ast_det_varchar16],[ast_det_varchar21],[ast_det_mfg_cd])
--INCLUDE ([mst_RowID],[ast_det_asset_cost],[ast_det_varchar15],[ast_det_note1],[ast_det_purchase_date],[ast_det_cus_code])


--GO
--CREATE NONCLUSTERED INDEX ix_siteod
--ON [dbo].[wko_det] ([site_cd],[mst_RowID])
--INCLUDE ([wko_det_wr_no],[wko_det_exc_date],[wko_det_cmpl_date],[wko_det_corr_action],[wko_det_varchar8],[wko_det_assign_to])

declare @temp table
(
state_desc varchar(300)
,total_wo  int
,wo_comp_within_kpi int
,wo_comp_out_kpi int
,tot_pen_amt numeric(28,2)
,maintenance_flag varchar(10)
,wo_pending int
,asset_type   varchar(100)
,clinic_code  varchar(100)
,clinic_type  varchar(100)
,actual_response_kpi int
)

declare @repair_time table
(
clinic_type   varchar(100)
,penalty_days int
,asset_type   varchar(100) 
)

insert @repair_time
(
clinic_type   
,penalty_days 
,asset_type   
)
select 'kd',5,'cr'--critical
union 
select 'kd',5,'ps'--patient support
union
select 'kd',5,'ba'--basic

union
--ot means other clinic types
select null,3,'cr'--critical
union 
select null,4,'ps'--patient support
union
select null,4,'ba'--basic

 insert @temp(state_desc,maintenance_flag)
 /*--commented by murugan request by sekar
 select State,'c'
 from   Tsd_penalty_report_tab_tmp (nolock)
 where  guid = @guid
 union
 
 select State,'p'
 from   Tsd_penalty_report_tab_tmp (nolock)
 where  guid = @guid
 */
  select ast_loc_state,'c'
 from   ast_loc (nolock)
 
 union
 
 select ast_loc_state,'p'
 from   ast_loc (nolock)
 

-- truncate table Tsd_penalty_report_tab_tmp
-- update t
-- set    t.total_wo = tmp.total_wo
-- ,wo_pending = wo_pend

-- from   @temp t
-- join   (select    t.state 'state_desc'
--					,count(distinct [WO Number]) 'total_wo'
--					,sum(iif([WO Status] = 'ope',1,0)) 'wo_pend'
--					, wko_mst_type
--         from      Tsd_penalty_report_tab_tmp t
		 
--		 group by state ,wko_mst_type
--		 ) tmp

--on t.state_desc = tmp.state_desc
-- and t.maintenance_flag = tmp.wko_mst_type
   /*
   insert @temp
   (
   state_desc
   ,maintenance_flag
   ,wo_comp_within_kpi
   ,wo_comp_out_kpi
   ,tot_pen_amt
   ,total_wo
   ,wo_pending
   )

   select state
        ,wko_mst_type
		, sum(iif([actual response kpi] <= penalty_days ,1,0)) 'wo_comp_within_kpi'
	,sum(iif([actual response kpi] > penalty_days ,1,0)) 'wo_comp_out_kpi'
	,sum(total_penalty_cost) 'total_penalty_cost'
	,count(distinct [WO Number]) 'total_wo'
					,sum(iif([WO Status] = 'ope',1,0)) 'wo_pend'
 from   Tsd_penalty_report_tab_tmp (nolock)t
 join   @repair_time r 
 on t.[ClinicType]  = isnull(r.clinic_type,t.[ClinicType])
 and t.[BeGroup] = r.asset_type

 where guid = @guid



 --assettype
 group by state
        ,wko_mst_type
 */
 
 update t
 set    t.total_wo = tmp.total_wo
        ,t.actual_response_kpi = tmp.actual_response_kpi
		--,t.tot_pen_amt = tmp.total_penalty_cost
 from   @temp t
 join
 (
 select  state
        ,wko_mst_type
		,sum([actual response kpi]) actual_response_kpi
		,count(distinct [WO Number]) 'total_wo'
		--,sum(total_penalty_cost) 'total_penalty_cost'
 from   Tsd_penalty_report_tab_tmp   (nolock)t
 group by  state
        ,wko_mst_type

 ) tmp
 on t.state_desc = tmp.state
 and t.maintenance_flag = tmp.wko_mst_type

 
 update t
 set  t.wo_pending = tmp.wo_pend
         
 from   @temp t
 join
 (
 select  state
        ,wko_mst_type
		 
		,count(distinct [WO Number]) 'wo_pend'
	 
 from   Tsd_penalty_report_tab_tmp   (nolock)t

 --select wko_mst_asset_level as state,wko_mst_type,count(wko_mst_wo_no) 'wo_pend'
 --from wko_mst
  

 where [WO Status] = 'OPE'
 --wko_mst_status = 'OPE'
 --and wko_mst_org_date between @start_date and @sysdate

 group by state--- wko_mst_asset_level
        ,wko_mst_type

 ) tmp
 on t.state_desc = tmp.state
 and t.maintenance_flag = tmp.wko_mst_type


 UPDATE T
 SET  t.wo_comp_within_kpi = tmp.wo_comp_within_kpi
 ,t.wo_comp_out_kpi =  tmp.wo_comp_out_kpi
 --,t.tot_pen_amt = iif(tmp.wo_comp_out_kpi > 0 ,total_penalty_cost,null)
 FROM   @temp T
 JOIN
 ( 
    select state
         ,wko_mst_type
	 , sum (iif(actual_response_kpi <= penalty_days ,1,0)) 'wo_comp_within_kpi'
	 , sum(iif(actual_response_kpi > penalty_days ,1,0)) 'wo_comp_out_kpi'
	--,  sum(total_penalty_cost) over(PARTITION by t.State,t.wko_mst_type ) 'total_penalty_cost'
	from 
			(
			  select  state,wko_mst_type,[wo number],t.[ClinicType],t.[BeGroup] , sum([Actual Repair KPI]) 'actual_response_kpi'
			  --,sum(total_penalty_cost) 'total_penalty_cost'
			 from   Tsd_penalty_report_tab_tmp (nolock) t
			  --where guid = @guid
			 group by  state,wko_mst_type,[wo number],t.[ClinicType],t.[BeGroup] 
			) t

 join   @repair_time r 
 on t.[ClinicType]  = isnull(r.clinic_type,t.[ClinicType])
 and t.[BeGroup] = r.asset_type
 group by state
        ,wko_mst_type

 ) tmp

 on t.state_desc =tmp.state
 and t.maintenance_flag = tmp.wko_mst_type


 
 UPDATE T
 SET   
 t.tot_pen_amt = iif(t.wo_comp_out_kpi > 0 ,total_penalty_cost,null)
 FROM   @temp T
 join (
			  select  state,wko_mst_type 
			  ,sum(total_penalty_cost) 'total_penalty_cost'
			 from   Tsd_penalty_report_tab_tmp (nolock) t
			  --where guid = @guid
			 group by  state,wko_mst_type 
			) a
on t.state_desc =a.state
 and t.maintenance_flag = a.wko_mst_type

  
 
 --update t
 --set    t.wo_comp_within_kpi = tmp.wo_comp_within_kpi
 --,t.wo_comp_out_kpi = tmp.wo_comp_out_kpi
 --,t.tot_pen_amt = tmp.total_penalty_cost
 --, t.total_wo = tmp.total_wo
 --,wo_pending = wo_pend
 --from @temp t
 --join
 --(
 --select state
 --       ,wko_mst_type
	--	--, sum(iif(sum([actual response kpi]) <= penalty_days ,1,0)) 'wo_comp_within_kpi'
	--		,  (iif(sum([actual response kpi]) <= penalty_days ,1,0)) 'wo_comp_within_kpi'
	--, (iif(sum([actual response kpi]) > penalty_days ,1,0)) 'wo_comp_out_kpi'
	--,sum(total_penalty_cost) 'total_penalty_cost'
	--,count(distinct [WO Number]) 'total_wo'
	--				,sum(iif([WO Status] = 'ope',1,0)) 'wo_pend'
 --from   Tsd_penalty_report_tab_tmp (nolock)t
 --join   @repair_time r 
 --on t.[ClinicType]  = isnull(r.clinic_type,t.[ClinicType])
 --and t.[BeGroup] = r.asset_type

 --where guid = @guid



 ----assettype
 --group by state
 --       ,wko_mst_type
 
 --) tmp

 --on t.state_desc = tmp.state
 --and t.maintenance_flag = tmp.wko_mst_type
  

select 
 @be_category				'be_category'
,@getdate					'date'
,@manufacture				'manufacture'
,@model						'model'
,@batch						'batch'
,@supp_name					'suppliername'
,state_desc					'state'
, total_wo	        			'total_wo'
, wo_comp_within_kpi   	'wo_completed_within_kpi'
, wo_comp_out_kpi	 				'wo_completed_out_of_kpi'
, wo_pending			 		'wo_pending'
, tot_pen_amt		 		'total_pen_amt'
,lower(maintenance_flag)			'maintenance_flag'

from @TEMP




DELETE Tsd_penalty_report_tab_tmp-- where guid = @guid

 

/*
select
'be_category'					'be_category'
,'date'							'date'
,'manufacture'					'manufacture'
,'model'							'model'
,'batch'							'batch'
,'suppliername'					'suppliername'
,'state'							'state'
,'total_wo'						'total_wo'
,'wo_completed_within_kpi'		'wo_completed_within_kpi'
,'wo_completed_out_of_kpi'		'wo_completed_out_of_kpi'
,'wo_pending'					'wo_pending'
,'total_pen_amt'					'total_pen_amt'
,'maintenance_flag'				'maintenance_flag'
*/
set nocount off

 
 
end





