alter procedure sp_uptime_kpi_report_out_yearly
@statename		varchar(100)		= 'perak',
@district		varchar(200) = 'all',
--@zone varchar(200),
@cliniccategory varchar(100) ='all',
@periodfrom		date = '2018-01-01' ,
@periodto		date = '2018-12-31',
--@year varchar(20) =null,
@ownership		varchar(200) = 'all' -- with encryption

as
begin
set nocount on


declare @startdate datetime = concat(year(@periodfrom),'-01-01')
declare @enddate   datetime = concat(year(@periodfrom),'-12-31 23:59:00.000')

declare @state  varchar(100),
		@dis  varchar(100),
		@clinic varchar(100),
		@owner varchar(200)
		 
		
		
		
set @state		= @statename
set @dis		= @district
set @clinic		= @cliniccategory
set @owner		= @ownership


if @state in ('all','0')
begin
set @state = null
end

if @dis in  ('all','0')
begin
set @dis = null
end

if @clinic in  ('all','0')
begin
set @clinic = null
end

if @owner in  ('all','0')
begin
set @owner = '%'
end

truncate table tsd_uptime_report_year_tab
truncate table tsd_uptime_wo_rpt_tbl


if year(@enddate )  <= 2017
begin
insert tsd_uptime_report_year_tab
(
 asset_no
,be_category
,begroup
,ageofbe
,ownership
,state
,district
,zone
,clinic_name
,clinic_category
,purchase_cost
,[be status]
,[actual working days year]
,[First Level Status]
,[Second Level Status]
)

select
m.ast_mst_asset_no as asset_no
,m.ast_mst_asset_longdesc as be_category
,m.ast_mst_asset_type as begroup
,ceiling(coalesce(cast(datediff(dayofyear, ast_det_purchase_date, @enddate) as decimal(12, 5)) / 365, 16)) as ageofbe
,ast_det_varchar15 as ownership
,m.ast_mst_ast_lvl as state
,m.ast_mst_asset_locn as district
,m.ast_mst_perm_id as zone
,ast_det_note1 as clinic_name
,ast_mst_asset_code as clinic_category
,ast_det_asset_cost as purchase_cost
,a.ast_aud_status as [be status]
,246 as [actual working days year]
,'YES' as 'First Status'
,'YES'  as 'Second Status'
from  ast_mst m (nolock)
join  ast_det d (nolock)
on    m.rowid = d.mst_rowid
and   m.site_cd = d.site_cd
join  ast_aud a (nolock)
on    a.mst_rowid = m.rowid
and   a.site_cd = m.site_cd
and   m.site_cd = 'qms'
and   a.ast_aud_status = 'act'
and   a.ast_aud_start_date <= @startdate
and	  isnull(a.ast_aud_end_date,@enddate) >= @enddate
and   (m.ast_mst_ast_lvl = @state or @state is null)
and   (m.ast_mst_asset_locn = @dis or @dis	is null)
and   (m.ast_mst_asset_code	=	@clinic	or @clinic	is	null)
and	  d.ast_det_varchar15 in (	select ownership_type 
								from ownership_mst (nolock) 
								where ownership_desc not in ('accessories') 
								and  ownership_desc like @owner
							 ) 
and  ast_mst_asset_grpcode not in ('11-165n','11-165n','10-792n','10-792','de-032n','de-032')
end
else
begin
insert tsd_uptime_report_year_tab
(
 asset_no
,be_category
,begroup
,ageofbe
,ownership
,state
,district
,zone
,clinic_name
,clinic_category
,purchase_cost
,[be status]
,[actual working days year]
,[First Level Status]
,[Second Level Status]
)

select
m.ast_mst_asset_no as asset_no
,m.ast_mst_asset_longdesc as be_category
,m.ast_mst_asset_type as begroup
,ceiling(coalesce(cast(datediff(dayofyear, ast_det_purchase_date, @enddate) as decimal(12, 5)) / 365, 16)) as ageofbe
,ast_det_varchar15 as ownership
,m.ast_mst_ast_lvl as state
,m.ast_mst_asset_locn as district
,m.ast_mst_perm_id as zone
,ast_det_note1 as clinic_name
,ast_mst_asset_code as clinic_category
,ast_det_asset_cost as purchase_cost
,a.ast_aud_status as [be status]
,246 as [actual working days year]
,'YES' as 'First Status'
,'YES'  as 'Second Status'
from  ast_mst m (nolock)
join  ast_det d (nolock)
on    m.rowid = d.mst_rowid
and   m.site_cd = d.site_cd
join  ast_aud a (nolock)
on    a.mst_rowid = m.rowid
and   a.site_cd = m.site_cd
and   m.site_cd = 'qms'
and   a.ast_aud_status = 'act'
and   a.ast_aud_start_date <= @startdate
and	  isnull(a.ast_aud_end_date,@enddate) >= @enddate
and   (m.ast_mst_ast_lvl = @state or @state is null)
and   (m.ast_mst_asset_locn = @dis or @dis	is null)
and   (m.ast_mst_asset_code	=	@clinic	or @clinic	is	null)
and	  d.ast_det_varchar15 in (	select ownership_type 
								from ownership_mst (nolock) 
								where ownership_desc not in ('accessories') 
								and  ownership_desc like @owner
							 ) 
 --where  m.ast_mst_asset_no= 'PRK010871'

end
--remove dublicate asset entry
;with cte as (select asset_no , row_number() over(partition by asset_no order by asset_no) 'rn' from tsd_uptime_report_year_tab )
delete cte where rn > 1

--get list of work request on the given period
insert tsd_uptime_wo_rpt_tbl
(
asset_no
,wr_no
,wr_date
,wo_no
,wo_cmpl_date
)
select m.wkr_mst_assetno,m.wkr_mst_wr_no,m.wkr_mst_org_date,d.wkr_det_wo,wd.wko_det_cmpl_date
from   wkr_mst m (nolock)
join   tsd_uptime_report_year_tab t (nolock) on t.asset_no = m.wkr_mst_assetno
join   wkr_det d (nolock) on m.rowid =d.mst_rowid
join   wko_mst wm (NOLOCK) on wm.wko_mst_wo_no = d.wkr_det_wo
join   wko_det wd (NOLOCK) on wd.mst_rowid = wm.rowid
where -- wkr_mst_org_date between @startdate and @enddate
     m.wkr_mst_wr_status <> 'd'
aND ( (    wkr_mst_org_date between @startdate and @enddate) 
			or 
			(	wkr_mst_org_date <  @startdate
				and (isnull(wko_det_cmpl_date,@enddate) >= @enddate or isnull(wko_det_cmpl_date,@enddate) between @startdate and  @enddate) 
				--or (wm.wko_mst_status NOT IN ('CLO','CMP') and wm.wkr_mst_org_date <= @enddate)
			)
		--	or (wm.wko_mst_status NOT IN ('CLO','CMP') and wkr_mst_org_date <= @enddate)
	)
	--WKR199940

	 
--update w
--set   wo_cmpl_date = d.wko_det_cmpl_date
--from  tsd_uptime_wo_rpt_tbl w
--join  wko_mst m (nolock) on w.wo_no = m.wko_mst_wo_no
--join  wko_det d (nolock) on m.rowid = d.mst_rowid
--SELECT @startdate '@startdate'--test

update  tsd_uptime_wo_rpt_tbl
set		wo_cmpl_date = @enddate
where   isnull(wo_cmpl_date,@enddate) >= @enddate

update  tsd_uptime_wo_rpt_tbl
set     wr_date = @startdate
where   wr_date < @startdate
 
update  tsd_uptime_wo_rpt_tbl
set     down_time = ceiling(cast(datediff(mi, wr_date, wo_cmpl_date) as decimal(12, 5)) / 60 / 24)


--test
--SELECT * from tsd_uptime_wo_rpt_tbl
;with all_dates as (SELECT @startdate 'date',DATENAME(dw,@startdate) 'datename' UNION all SELECT dateadd(dd,1,date),DATENAME(dw,dateadd(dd,1,date)) 'datename'
 from all_dates where date < cast(@enddate as date))

--SELECT * from all_dates where datename in ('Friday','Saturday','Sunday') option (maxrecursion 0)

update t
set    holidays = case @state when 'johor' then (
													(SELECT count (*) from Report_holiday_mst (nolock) 
													where statename = @state
													and convert(date,holidaydate) between convert(date,t.wr_date) and convert(date,t.wo_cmpl_date)
													and Datename(dw,holidaydate) not in ('Friday','Saturday') 
													) 
											+			
													(SELECT count(*) 
													from  all_dates 
													where datename in ('Friday','Saturday') 
													and date between cast(t.wr_date as date) and cast(t.wo_cmpl_date  as date)					 
													)
												)
											ELSE
											(
													(SELECT count (*) from Report_holiday_mst (nolock) 
													where statename = @state
													and convert(date,holidaydate) between convert(date,t.wr_date) and convert(date,t.wo_cmpl_date)
													and Datename(dw,holidaydate) not in ('Saturday','Sunday')  
													) 
											+			
													(SELECT count(*) 
													from  all_dates 
													where datename in ('Saturday','Sunday') 
													and date between cast(t.wr_date as date) and cast(t.wo_cmpl_date  as date)					 
													)
												)

							END				 
FROM   tsd_uptime_wo_rpt_tbl t
OPTION (MAXRECURSION 400)



--test
--SELECT asset_no 'Asset No',wr_no 'WR Number',format(wr_date,'dd/MM/yyyy hh:mm') 'WR Date',wo_no 'WO Number',format(wo_cmpl_date,'dd/MM/yyyy hh:mm') 'WO Cmpl date',down_time 'Down time',holidays from tsd_uptime_wo_rpt_tbl

update  tsd_uptime_wo_rpt_tbl
set     down_time = down_time - holidays
where   down_time > 0

--SELECT * from tsd_uptime_wo_rpt_tbl order by wr_date
--JHR011085 --5
update t 
set    [total downtime] = sum_down_time
from   tsd_uptime_report_year_tab t
join   (select asset_no,sum(down_time) sum_down_time  from tsd_uptime_wo_rpt_tbl w (nolock) group by asset_no ) w
on	   t.asset_no = w.asset_no	

Update tsd_uptime_report_year_tab
set [Total Uptime] = isnull([Actual Working Days Year],0) - isnull([Total Downtime],0)
 
update tab
set  [First Level Days]= Firstlevel  , [Second Level Days] = Secondlevel
from tsd_uptime_report_year_tab tab (nolock),
	Uptime_KPI_Day_mst mst (nolock) -- commented by murugan on 10/04/2019
	--dwntime_KPI_Day_mst mst (NOLOCK)
where    mst.BeGroup = tab.BeGroup
and AgeofBE between minage and maxage


update t set 
t.less_than_1_uptime_grnt = u.less_than_1_uptime_grnt
,t.less_than_2_uptime_grnt = u.less_than_2_uptime_grnt
from tsd_uptime_report_year_tab (nolock) t
join uptime_kpi_penalt_mst u (NOLOCK)
on t.purchase_cost BETWEEN u.purchase_val_from and isnull(u.purchase_value_to,t.purchase_cost)

update t set 
less_than_1_uptime_penlty = u.less_than_1_uptime_grnt
,[First Level Status] = 'NO'
from  tsd_uptime_report_year_tab t
join
uptime_kpi_penalt_mst u (NOLOCK)
 on t.purchase_cost BETWEEN u.purchase_val_from and isnull(u.purchase_value_to,t.purchase_cost)
where [First Level Days] <  [Total Uptime]  


update t set 
less_than_2_uptime_penlty = u.less_than_2_uptime_grnt
,[Second Level Status] = 'NO'
from  tsd_uptime_report_year_tab t join
uptime_kpi_penalt_mst u (NOLOCK)
 on t.purchase_cost BETWEEN u.purchase_val_from and isnull(u.purchase_value_to,t.purchase_cost)
where [Second Level Days] < [Total Uptime] 


update tsd_uptime_report_year_tab
set    [First Level Status] = 'YES',[Second Level Status] = 'YES'
       ,less_than_1_uptime_penlty = null ,less_than_2_uptime_penlty = null
Where  AgeofBE  >=16 

 SELECT * from tsd_uptime_report_year_tab (NOLOCK)

set nocount off
end



