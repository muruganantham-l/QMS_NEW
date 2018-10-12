
--exec SP_uptime_kpi_Report_out_summary 'PERAK' ,'ALL','ALL', 'ALL' , '2017-01-01','2017-12-31','Existing'

Alter  Procedure SP_uptime_kpi_Report_out_summary
@statename varchar(100) = 'ALL',
@district varchar(200) ,
@zone varchar(200),
@cliniccategory varchar(100),
@periodfrom Date = '2017-01-01' ,
@periodto date = '2017-01-31',
@ownership varchar(200) = 'EXISTING' -- WITH ENCRYPTION

as 


begin

set nocount on

Declare @startdate Datetime
Declare @enddate datetime
Declare @yearstart datetime
--Declare @periodfrom varchar(15)
--Declare @periodto varchar(15)

Declare @Year int = year( @periodfrom )

--Select  DATEADD(yy, 2017-1900 , 0) 

Select @yearstart = DATEADD(yy, @Year-1900 , 0) 

Select @startdate = isnull(@yearstart ,'2017-01-01')
Select @enddate   = isnull(@periodto,convert(date,getdate()))



if @statename in ('ALL','0')
begin
	set @statename = 'ALL'
end


if @cliniccategory in  ('ALL','0')
begin
	set @cliniccategory = NULL
end

if @ownership in  ('ALL','0')
begin
	set @ownership = '%'
end


Declare @startdate_temp Datetime
Declare @enddate_temp Datetime

--Truncate table Tsd_Uptime_Detail_tab
--Truncate Table Tsd_Uptime_report_tab

Declare @guid varchar(100) =   newid()  -- @guid

select @startdate_temp = @startdate


select @enddate_temp = CONVERT(datetime,DATEADD(SS,-1,Dateadd(YY,1,@startdate_temp)))

if  @statename = 'ALL' 
begin

insert into Tsd_Uptime_report_tab
(

GUID
,[Asset_no]
,[BE_Category]
,[Asset_Cost]
,[BeGroup]
,[MonthStart]
,[MonthEnd]
,[AgeofBE]
,[BE Status]
,[Zone]
,[State]
,[Circle]
,[District]
,[clinic_code]
,[clinic_name]
,[clinic_category]
,[Remarks]
,[ClinicType]
,[Ownership]
,[Month Name]
,[Actual Downtime]
,[Total Downtime]
,[Total Uptime]
,[Actual Working Days Year]
,[Actual Working Days Month]
,[No Days Month]
,[No Days Up Month]
,[Total No Days Up]
,[Holidays&Weekends]
,[First Level Days]
,[Second Level Days]
,[First Level Status]
,[Second Level Status]
,[penalty_cost]
,[Uptime_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
)
select 
 @guid
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
,ast_mst_asset_type 
,CONVERT(DATETIME, @startdate_temp)
,CONVERT(DATETIME, @enddate_temp)
,COALESCE(Year(@yearstart) - year(ast_det.ast_det_purchase_date),16) Age
,ast_mst_asset_status
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,ast_det_cus_code
,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
,ast_mst_asset_code
,''
,cus_mst.cus_mst_fob
,ast_det_varchar15
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,0 as 'Down Time'
,0 AS 'Total Downtime'
,0 AS 'Total Uptime'
,246 as 'Actual Working Days Year'
,0 as 'Actual Working Days Month'
,(Datediff(dd,@startdate_temp,@enddate_temp)+1) as 'No Days Month'
,0 as 'No Days Up Month'
,0 as 'Total No Days Up'
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,@startdate_temp,@enddate_temp) 'Holidays'
,0 as Firstlevel
,0 as Secondlevel
,'YES' as 'First Status'
,'YES'  as 'Second Status'
,0 
,0
,0
,ast_aud_status AS 'Period_Status'
FROM ast_mst (nolock)
	,ast_det (nolock)
	,cus_mst (nolock)
	,ast_aud (nolock)
WHERE (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (ast_mst.site_cd = ast_aud.site_cd)
	AND (ast_mst.RowID = ast_aud.mst_RowID)
	AND (ast_aud_asset_no = ast_mst_asset_no)
	AND ast_aud_status in ('ACT','PBR')
	AND ast_mst_asset_grpcode not in ('11-165N','11-165N','10-792N','10-792','DE-032N','DE-032')
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	--AND (ast_mst_ast_lvl = isnull(@statename,ast_mst_ast_lvl) )
	----AND ast_mst.ast_mst_perm_id = isnull(@zone,ast_mst.ast_mst_perm_id)
	AND ast_mst.ast_mst_asset_code = isnull(@cliniccategory,ast_mst.ast_mst_asset_code)
	and ast_det_varchar15 not in ('Accessories')
	AND ast_det.ast_det_varchar15 in (	select Ownership_Type from ownership_mst (nolock) 
										where Ownership_desc not in ('Accessories') 
										and  Ownership_desc like @ownership 
										)
	AND ast_mst.ast_mst_create_date < @yearstart	
	AND (@yearstart-1)	between Convert(date,ast_aud_start_date ) and convert(date,isnull(ast_aud_end_date,@yearstart))


insert into workorder_master
Select  
wko_mst.site_cd 
,wko_mst.wko_mst_wo_no
,wkr_mst.wkr_mst_wr_no
,ast_mst_asset_no
,wko_det_assign_to
,wko_mst.wko_mst_org_date as [WO Datetime]
,wkr_mst.wkr_mst_org_date as [Wr Datetime]
,wko_det.wko_det_exc_date AS Response_Date
,wko_det.wko_det_cmpl_date AS [Completion Date]
,ast_mst_ast_lvl 
,ast_mst_asset_locn
,ast_det_varchar15
,ast_det_cus_code
,wko_mst_status
,wkr_mst_wr_status
,@Guid
from 
wkr_mst (nolock)
,wkr_det (nolock)
,wko_mst (nolock)
,wko_det (nolock)
,ast_mst (nolock)
,ast_det (nolock)
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
AND (wkr_mst.RowID = wkr_det.mst_RowID)
AND (wko_mst.site_cd = wko_det.site_cd)
AND (wko_mst.RowID = wko_det.mst_RowID)
AND (ast_mst.site_cd = ast_det.site_cd)
AND (ast_mst.RowID = ast_det.mst_RowID)
AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
AND (wkr_mst.wkr_mst_wr_status <> 'D') 
AND (ast_mst.site_cd = 'QMS')
AND ast_mst_asset_grpcode not in ('11-165N','11-165N','10-792N','10-792','DE-032N','DE-032')
AND ast_det_varchar15 not in ('Accessories')
AND ast_mst.ast_mst_asset_code = isnull(@cliniccategory,ast_mst.ast_mst_asset_code)
AND ast_mst.ast_mst_create_date < @yearstart
AND ( (wkr_mst_org_date between @startdate_temp and @enddate_temp) 
			or 
			(wkr_mst_org_date <  @startdate_temp
				and 
					(wko_det_cmpl_date >= @enddate_temp or wko_det_cmpl_date between @startdate_temp and  @enddate_temp) or wko_mst.wko_mst_status NOT IN ('CLO','CMP')))


end
else 
begin
insert into Tsd_Uptime_report_tab
(

GUID
,[Asset_no]
,[BE_Category]
,[Asset_Cost]
,[BeGroup]
,[MonthStart]
,[MonthEnd]
,[AgeofBE]
,[BE Status]
,[Zone]
,[State]
,[Circle]
,[District]
,[clinic_code]
,[clinic_name]
,[clinic_category]
,[Remarks]
,[ClinicType]
,[Ownership]
,[Month Name]
,[Actual Downtime]
,[Total Downtime]
,[Total Uptime]
,[Actual Working Days Year]
,[Actual Working Days Month]
,[No Days Month]
,[No Days Up Month]
,[Total No Days Up]
,[Holidays&Weekends]
,[First Level Days]
,[Second Level Days]
,[First Level Status]
,[Second Level Status]
,[penalty_cost]
,[Uptime_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
)
select 
 @guid
,ast_mst.ast_mst_asset_no
,ast_mst.ast_mst_asset_longdesc AS BE_Category
,ast_det.ast_det_asset_cost
,ast_mst_asset_type 
,CONVERT(DATETIME, @startdate_temp)
,CONVERT(DATETIME, @enddate_temp)
,COALESCE(Year(@yearstart) - year(ast_det.ast_det_purchase_date),16) Age
,ast_mst_asset_status
,ast_mst.ast_mst_perm_id AS Zone
,ast_mst.ast_mst_ast_lvl AS STATE
,ast_mst.ast_mst_work_area AS Circle
,ast_mst.ast_mst_asset_locn AS District
,ast_det_cus_code
,Replace(Replace(ast_det_note1,char(10),''),char(13),0) Clinicname
,ast_mst_asset_code
,''
,cus_mst.cus_mst_fob
,ast_det_varchar15
,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
,0 as 'Down Time'
,0 AS 'Total Downtime'
,0 AS 'Total Uptime'
,246 as 'Actual Working Days Year'
,0 as 'Actual Working Days Month'
,(Datediff(dd,@startdate_temp,@enddate_temp)+1) as 'No Days Month'
,0 as 'No Days Up Month'
,0 as 'Total No Days Up'
,dbo.[state_noofholidays](ast_mst.ast_mst_ast_lvl,@startdate_temp,@enddate_temp) 'Holidays'
,0 as Firstlevel
,0 as Secondlevel
,'YES' as 'First Status'
,'YES'  as 'Second Status'
,0 
,0
,0
,ast_aud_status AS 'Period_Status'
FROM ast_mst (nolock)
	,ast_det (nolock)
	,cus_mst (nolock)
	,ast_aud (nolock)
WHERE (ast_mst.site_cd = ast_det.site_cd)
	AND (ast_mst.RowID = ast_det.mst_RowID)
	AND (ast_mst.site_cd = ast_aud.site_cd)
	AND (ast_mst.RowID = ast_aud.mst_RowID)
	AND (ast_aud_asset_no = ast_mst_asset_no)
	AND ast_aud_status in ('ACT','PBR')
	AND ast_mst_asset_grpcode not in ('11-165N','11-165N','10-792N','10-792','DE-032N','DE-032')
	AND (ast_det.ast_det_cus_code = cus_mst.cus_mst_customer_cd)
	AND (ast_mst_ast_lvl = isnull(@statename,ast_mst_ast_lvl) )
	--AND ast_mst.ast_mst_perm_id = isnull(@zone,ast_mst.ast_mst_perm_id)
	AND ast_mst.ast_mst_asset_code = isnull(@cliniccategory,ast_mst.ast_mst_asset_code)
	and ast_det_varchar15 not in ('Accessories')
	AND ast_det.ast_det_varchar15 in (	select Ownership_Type from ownership_mst (nolock) 
										where Ownership_desc not in ('Accessories') 
										and  Ownership_desc like @ownership 
										)
	AND ast_mst.ast_mst_create_date < @yearstart	
	AND (@yearstart-1)	between Convert(date,ast_aud_start_date ) and convert(date,isnull(ast_aud_end_date,@yearstart))


insert into workorder_master
Select  
wko_mst.site_cd 
,wko_mst.wko_mst_wo_no
,wkr_mst.wkr_mst_wr_no
,ast_mst_asset_no
,wko_det_assign_to
,wko_mst.wko_mst_org_date as [WO Datetime]
,wkr_mst.wkr_mst_org_date as [Wr Datetime]
,wko_det.wko_det_exc_date AS Response_Date
,wko_det.wko_det_cmpl_date AS [Completion Date]
,ast_mst_ast_lvl 
,ast_mst_asset_locn
,ast_det_varchar15
,ast_det_cus_code
,wko_mst_status
,wkr_mst_wr_status
,@Guid
from 
wkr_mst (nolock)
,wkr_det (nolock)
,wko_mst (nolock)
,wko_det (nolock)
,ast_mst (nolock)
,ast_det (nolock)
WHERE (wkr_mst.site_cd = wkr_det.site_cd)
AND (wkr_mst.RowID = wkr_det.mst_RowID)
AND (wko_mst.site_cd = wko_det.site_cd)
AND (wko_mst.RowID = wko_det.mst_RowID)
AND (ast_mst.site_cd = ast_det.site_cd)
AND (ast_mst.RowID = ast_det.mst_RowID)
AND (wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no)
AND (ast_mst.ast_mst_asset_no = wko_mst.wko_mst_assetno)
AND (wkr_mst.wkr_mst_wr_status <> 'D') 
AND (ast_mst.site_cd = 'QMS')
AND ast_mst_asset_grpcode not in ('11-165N','11-165N','10-792N','10-792','DE-032N','DE-032')
AND ast_det_varchar15 not in ('Accessories')
AND ast_mst.ast_mst_ast_lvl = isnull(@statename,ast_mst.ast_mst_ast_lvl)
AND ast_mst.ast_mst_create_date < @yearstart
AND ( (wkr_mst_org_date between @startdate_temp and @enddate_temp) 
			or 
			(wkr_mst_org_date <  @startdate_temp
				and 
					(wko_det_cmpl_date >= @enddate_temp or wko_det_cmpl_date between @startdate_temp and  @enddate_temp) or wko_mst.wko_mst_status NOT IN ('CLO','CMP')))

end

insert into Tsd_Uptime_Detail_tab (GUID,[Asset_no],[Wr Datetime],[Completion Date && Time], MonthStart, MonthEnd, State , District, Ownership, clinic_code, [WR Status] ,[WO Status],[WR Month])
SELECT  @Guid,
		s1.ast_mst_asset_no,
		s1.[Wr Datetime], 
       MIN(t1.[Completion Date]) AS EndDate ,
	   @startdate_temp,
	   @enddate_temp,
	   s1.ast_mst_ast_lvl ,
	   s1.ast_mst_asset_locn,
	   s1.ast_det_varchar15,
	   s1.ast_det_cus_code,
	   s1.wkr_mst_wr_status,
	   s1.wko_mst_status
	   ,convert(varchar,month(@startdate_temp))+'.'+Left(Datename(mm,@startdate_temp),3)+'-'+ right(Convert(varchar,year(@startdate_temp)),2)
FROM   workorder_master (nolock) s1 
INNER JOIN workorder_master (nolock) t1 
ON s1.ast_mst_asset_no = t1.ast_mst_asset_no 
and  s1.[Wr Datetime] <= t1.[Completion Date]
  AND NOT EXISTS(SELECT * FROM workorder_master (nolock) t2 
WHERE t1.ast_mst_asset_no = t2.ast_mst_asset_no and t1.[Completion Date] >= t2.[Wr Datetime] AND t1.[Completion Date] < t2.[Completion Date]
) 
WHERE NOT EXISTS(SELECT * FROM workorder_master (nolock) s2 
WHERE s1.ast_mst_asset_no = s2.ast_mst_asset_no 
and s1.[Wr Datetime] > s2.[Wr Datetime] AND s1.[Wr Datetime] <= s2.[Completion Date]) 
GROUP BY s1.ast_mst_asset_no, s1.[Wr Datetime] ,s1.ast_mst_ast_lvl ,
	   s1.ast_mst_asset_locn,
	   s1.ast_det_varchar15,
	   s1.ast_det_cus_code,
	   s1.wkr_mst_wr_status,
	   s1.wko_mst_status
ORDER BY s1.ast_mst_asset_no,s1.[Wr Datetime] 

Delete from workorder_master
where Guid = @Guid

---SELECT @startdate_temp = CONVERT(datetime,DATEADD(mm,1,CONVERT(DATETIME,@startdate_temp)))



update Tsd_Uptime_Detail_tab
set [Actual Downtime] = CEILING(CAST(DATEDIFF(MI, [MonthStart],  isnull([Completion Date && Time],MonthEnd)) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and [Wr Datetime] <= [MonthStart]
and  [Guid] = @guid


update Tsd_Uptime_Detail_tab
set [Actual Downtime] = CEILING(CAST(DATEDIFF(MI, [MonthStart], MonthEnd) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd 
and [Wr Datetime] <= [MonthStart]
and  [Guid] = @guid

update Tsd_Uptime_Detail_tab
set [Actual Downtime] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], isnull([Completion Date && Time],MonthEnd)) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) between [MonthStart] and MonthEnd
and [Wr Datetime] between [MonthStart] and MonthEnd
and  [Guid] = @guid

update Tsd_Uptime_Detail_tab
set [Actual Downtime] = CEILING(CAST(DATEDIFF(MI, [Wr Datetime], MonthEnd) AS DECIMAL(12, 5)) / 60 / 24)
where   isnull([Completion Date && Time],MonthEnd) >= MonthEnd
and [Wr Datetime] between [MonthStart] and MonthEnd
and  [Guid] = @guid



Update tab 
SET [Actual Downtime] = Isnull(Total,0.0) , [Total Downtime] = Isnull(Total,0.0) 
from 
	Tsd_Uptime_report_tab tab(nolock),
	(select 
	[Guid],[WR Month],[Asset_no],[BE_Category],[BeGroup],[MonthStart],[MonthEnd],[AgeofBE],[clinic_code],[clinic_name],[clinic_category]
	,[No Days Month], SUM([Actual Downtime]) Total ,COUNT(*) Count1
	from Tsd_Uptime_Detail_tab (nolock)
	where [Guid] = @guid
	group by [Guid],[WR Month],[Asset_no],[BE_Category],[BeGroup],[MonthStart],[MonthEnd],[AgeofBE],[clinic_code],[clinic_name],[clinic_category],[No Days Month]
	) Det
WHERE tab.[Guid] = @guid
and tab.[Asset_no] = Det.[Asset_no]
and [WR Month] = [Month Name]


Update t1
set [Total Downtime] = (select Sum([Actual Downtime])
	from Tsd_Uptime_report_tab t2(nolock)
	Where t1.[Guid]= t2.[GUID] 
	And t1.[Asset_no] = t2.[Asset_no]
	AND t1.[MonthStart] >= t2.[MonthStart] 
	) 
	from 
	Tsd_Uptime_report_tab t1 (nolock)
	WHERE t1.[Guid] = @guid
	

update tab
set  Period_Status = ast_aud_status
from Tsd_Uptime_report_tab tab (nolock),
	ast_mst (nolock),
	ast_aud (nolock)
where  [Guid] = @guid
and ast_mst.RowID = ast_aud.mst_RowID
AND ast_mst.site_cd = ast_aud.site_cd
AND ast_mst.site_cd = 'QMS'
AND ast_mst.ast_mst_asset_no = Asset_no
and Convert(date,MonthEnd) between ast_aud_start_date and Isnull(ast_aud_end_date,MonthEnd)


update tab
set  [First Level Days]= Firstlevel  , [Second Level Days] = Secondlevel
from Tsd_Uptime_report_tab tab (nolock),
	Uptime_KPI_Day_mst mst (nolock)
where  [Guid] = @guid
and mst.BeGroup = tab.BeGroup
and AgeofBE between minage and maxage


Update Tsd_Uptime_report_tab
set [Total Uptime] = [Actual Working Days Year] - [Total Downtime] , [Actual Working Days Month] = [No Days Month],[No Days Up Month] = [No Days Month]-[Actual Downtime]
where [Guid] = @guid

Update Tsd_Uptime_report_tab
set [First Level Status] = 'NO' , [First Level KPI] = 0 , TotalKPI = 1
where [Guid] = @guid
and [Total Uptime] < [First Level Days]

Update Tsd_Uptime_report_tab
set [Second Level Status] = 'NO' , [Second Level KPI]=0 , TotalKPI = 1
where [Guid] = @guid
and [Total Uptime] < [Second Level Days]
 

update Tsd_Uptime_report_tab
set Total_penalty_cost = 0.0 , Remarks = 'BE Age > 15 Years'
Where  [Guid] = @guid
and AgeofBE  >=16

Delete from Tsd_Uptime_Detail_tab
Where  [Guid] = @guid

update Tsd_Uptime_report_tab
set [First Level KPI] = 1 ,TotalKPI = 1
Where  [Guid] = @guid
and [First Level Status] = 'YES'

update Tsd_Uptime_report_tab
set [Second Level KPI] = 1,TotalKPI = 1
WHERE  [Guid] = @guid
and [Second Level Status]= 'YES'

--Alter table Tsd_Uptime_report_tab
--add AgeGroup varchar(100)

--Alter table Tsd_Uptime_report_tab
--add TotalKPI int

update Tsd_Uptime_report_tab
set [AgeGroup] = '0-5'
WHERE  [Guid] = @guid
and [AgeofBE] between 0 and 5

update Tsd_Uptime_report_tab
set [AgeGroup] = '6-10'
WHERE  [Guid] = @guid
and [AgeofBE] between 6 and 10

update Tsd_Uptime_report_tab
set [AgeGroup] = '11-15'
WHERE  [Guid] = @guid
and [AgeofBE] between 11 and 15

update Tsd_Uptime_report_tab
set [AgeGroup] = '>15'
WHERE  [Guid] = @guid
and [AgeofBE] >15


Select 
[Asset_no]
,[BE_Category]
,[Asset_Cost]
,[BeGroup]
,[MonthStart]
,[MonthEnd]
,[AgeofBE]
,[BE Status]
,[Zone]
,[State]
,[Circle]
,[District]
,[clinic_code]
,[clinic_name]
,[clinic_category]
,[Remarks]
,[ClinicType]
,[Ownership]
,[Month Name]
,[Actual Downtime]
,[Total Downtime]
,[Total Uptime]
,[Actual Working Days Year]
,[Actual Working Days Month]
,[No Days Month]
,[No Days Up Month]
,[Total No Days Up]
,[Holidays&Weekends]
,[First Level Days]
,[Second Level Days]
,[First Level Status]
,[Second Level Status]
,[penalty_cost]
,[Uptime_penalty_cost]
,[Total_penalty_cost]
,[Period_Status]
,[First Level KPI]
,[Second Level KPI]
,[TotalKPI]
,[AgeGroup]
 from Tsd_Uptime_report_tab (nolock)
where [Guid] = @guid

Delete from Tsd_Uptime_Detail_tab
where [Guid] = @guid


Delete from Tsd_Uptime_report_tab
where [Guid] = @guid

set nocount off

end


