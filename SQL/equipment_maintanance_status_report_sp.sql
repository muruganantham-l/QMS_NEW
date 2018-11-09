ALTER proc equipment_maintanance_status_report_sp
 @be_category		varchar(200)		= 'Electrocardiographs, Multichannel'
,@war_start_date	varchar(200)	 = '01/06/2017'
,@war_end_date      	varchar(200)	= '31/05/2018' 
,@manufacture		varchar(200)		= 'edan'	 
,@model				varchar(200)	= 'se-301'		 
,@batch				varchar(200)		= 'BATCH 3'
,@supp_name				varchar(200)	=  'MALAYSIAN HEALTHCARE SDN BHD'		 
as
begin
set nocount on
 


declare @sysdate date = getdate()

declare @start_date date =  convert(varchar(10), convert(date, @war_start_date, 103), 120)
		,@end_date  date =   convert(varchar(10), convert(date, @war_end_date, 103), 120) 


--SELECT 
--@be_category			'be_category'
--,@war_start_date		'war_start_date'
--,@war_end_date  		'war_end_date' 
--,@manufacture			'manufacture'	
--,@model					'model'			
--,@batch					'batch'			
--,@supp_name				'supp_name'		
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
,@ownership		varchar(200)
 
declare @month_end_date date = eomonth(dateadd(mm,3,@start_date))

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
--alter table Tsd_penalty_report_tab_tmp_qms
--add Capping numeric(30,4) 

--alter table Tsd_penalty_report_tab_tmp_qms
--add guid varchar(100)


--alter table Tsd_penalty_report_tab_tmp_qms
----add ast_det_varchar21 varchar(100)
----add ast_det_varchar16 varchar(100)
----add ast_det_mfg_cd varchar(25)
--add ast_mst_asset_longdesc varchar(100)

-- alter table Tsd_penalty_report_tab_tmp_qms
----add KPI_Remains int 
--add [ClinicType]  varchar(100)

--alter table Tsd_penalty_report_tab_tmp_qms
--add wko_mst_type varchar(10)


--alter table Tsd_penalty_report_tab_tmp_qms
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

 select State,'c'
 from   Tsd_penalty_report_tab_tmp_qms (nolock)
 where  guid = @guid
 union
 
 select State,'p'
 from   Tsd_penalty_report_tab_tmp_qms (nolock)
 where  guid = @guid

-- truncate table Tsd_penalty_report_tab_tmp_qms
-- update t
-- set    t.total_wo = tmp.total_wo
-- ,wo_pending = wo_pend

-- from   @temp t
-- join   (select    t.state 'state_desc'
--					,count(distinct [WO Number]) 'total_wo'
--					,sum(iif([WO Status] = 'ope',1,0)) 'wo_pend'
--					, wko_mst_type
--         from      Tsd_penalty_report_tab_tmp_qms t
		 
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
 from   Tsd_penalty_report_tab_tmp_qms (nolock)t
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
 from   Tsd_penalty_report_tab_tmp_qms   (nolock)t
 group by  state
        ,wko_mst_type

 ) tmp
 on t.state_desc = tmp.state
 and t.maintenance_flag = tmp.wko_mst_type

 
 update t
 set    t.wo_pending = tmp.wo_pend
         
 from   @temp t
 join
 (
 select  state
        ,wko_mst_type
		 
		,count(distinct [WO Number]) 'wo_pend'
	 
 from   Tsd_penalty_report_tab_tmp_qms   (nolock)t

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
 ,t.tot_pen_amt = iif(tmp.wo_comp_out_kpi > 0 ,total_penalty_cost,null)
 FROM   @temp T
 JOIN
 ( 
    select state
         ,wko_mst_type
	 , sum (iif(actual_response_kpi <= penalty_days ,1,0)) 'wo_comp_within_kpi'
	 , sum(iif(actual_response_kpi > penalty_days ,1,0)) 'wo_comp_out_kpi'
	,  sum(total_penalty_cost) 'total_penalty_cost'
	from 
			(
			  select  state,wko_mst_type,[wo number],t.[ClinicType],t.[BeGroup] , sum([Actual Repair KPI]) 'actual_response_kpi',sum(total_penalty_cost) 'total_penalty_cost'
			 from   Tsd_penalty_report_tab_tmp_qms (nolock) t
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
 --from   Tsd_penalty_report_tab_tmp_qms (nolock)t
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




DELETE Tsd_penalty_report_tab_tmp_qms-- where guid = @guid

 

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

