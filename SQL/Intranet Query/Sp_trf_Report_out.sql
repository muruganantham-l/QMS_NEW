--exec Sp_trf_Report_out 'PERAK','ALL','2015-07-10', '2017-07-12'
Alter procedure Sp_trf_Report_out
@state nvarchar(100),
@location nvarchar(100),
@receivefrom date ,
@receiveto date
as 
begin
set nocount on
Declare @Guid varchar(100)

select @guid = newid()

if @state in ('ALL','0','')
begin 
	select @state = '%'
end
else
begin 
	select @state = '%'+@state
end

if @location in ('ALL','0','')
begin 
	select @location = '%'
end
else
begin 
	select @location = '%'+@location
end

insert into qms_mmd_trf_tab 
([Guid]
,[NUM]
,[STATE NAME]
,[FROM STOCK LOCATION]
,[TO STOCK LOCATION]
,[STOCK NUM]
,[STOCK DESCR]
,[PART NUM]
,[UOM]
,[STOCK COST (RM)]
,[CAMMS TRF DATE]
,[ACTUAL TRF DATE]
,[TRF QTY]
,[TRF NUM]
,[TOTAL TRF COST (RM)]
,[TRF BY (NAME)]
,[TRF REQUESTED BY (REMARK)]
,[TRF PURPOSE (REMARK)]
)

select 
@guid,
DENSE_RANK() over ( order by itm_trx_doc_no ) [NUM], 
NULL [STATE NAME],
isnull(itm_trx_stk_locn ,'') [STOCK FROM LOCATION],
isnull(itm_trx_to_stk_locn,'') [STOCK TO LOCATION],
isnull(itm_trx_stockno ,'') [STOCK NUM],
itm_trx_desc [STOCK DESCR],
isnull(itm_mst_partno,'') [PART NUM],
itm_trx_uom [UOM],
itm_trx_item_cost [ITEM COST (RM)] ,
convert(varchar ,itm_trx_curr_date,120)  [CAMMS TRF DATE],
convert(varchar ,itm_trx_trx_date,120)  [ACTUAL TRF DATE],
isnull(itm_trx_isu_qty,0) [TRF QTY],
itm_trx_doc_no [TRF NUM],
isnull(isnull(itm_trx_isu_qty,0)* itm_trx_item_cost ,0.0) [TOTAL COST (RM)],
isnull(itm_trx_login_id,'') [TRF BY (NAME)],
replace(Replace(isnull(itm_trx_remark,''),char(10),''),char(13),'') [TRF REQUESTED BY (REMARK)],
replace(Replace(isnull(itm_trx_remark,''),char(10),''),char(13),'') [TRF PURPOSE (REMARK)]
FROM  
itm_trx (nolock)  ,
itm_mst (NOLOCK)
where itm_trx.site_cd = 'QMS'
and itm_trx.site_cd = itm_mst.site_cd
and itm_trx_trx_type = 'MT61'
and itm_trx_isu_qty = itm_trx_rcv_qty
and left(itm_trx_stockno,3) = 'STK'
and itm_mst_stockno  = itm_trx_stockno
and  convert(date,itm_trx_trx_date ) between @receivefrom and @receiveto
order by itm_trx_doc_no

/*Update state name */

update tab
set [STATE NAME] = SatateDesc 
from 
qms_mmd_trf_tab  tab (NOLOCK),
inv_trans_Location_det det (nolock),
inv_trans_Location_mst mst (nolock)
where [Guid] = @Guid
and tab.[FROM STOCK LOCATION] = Stocklocation
and Stocklocation like @location
and det.Statecode = mst.Statecode
and [STATE NAME] is NULL


/*Update state name */

Delete from qms_mmd_trf_tab 
where [Guid] = @Guid
and [STATE NAME] is NULL


/*Update GRN By name*/

update tab
set [TRF BY (NAME)] = emp_mst_name
from qms_mmd_trf_tab  tab (NOLOCK),
	emp_mst mst (NOLOCK)
	where [Guid] = @Guid
	and [TRF BY (NAME)] = emp_mst_login_id 
	and site_cd = 'QMS'

/*Update Employee Receive by  name*/

update tab
set [TRF BY (NAME)] = emp_mst_name
from qms_mmd_trf_tab  tab (NOLOCK),
	emp_mst mst (NOLOCK)
	where [Guid] = @Guid
	and [TRF BY (NAME)] = emp_mst_login_id 
	and site_cd = 'QMS'

/*Update Invoice status update By name*/

update tab
set [TRF REQUESTED BY (REMARK)] = emp_mst_name
from qms_mmd_trf_tab  tab (NOLOCK),
	emp_mst mst (NOLOCK)
	where [Guid] = @Guid
	and [TRF REQUESTED BY (REMARK)] = emp_mst_login_id 
	and site_cd = 'QMS'

/*Select statement for Required Columns*/

SELECT 
[NUM]
,[STATE NAME]
,[FROM STOCK LOCATION]
,[TO STOCK LOCATION]
,[STOCK NUM]
,[STOCK DESCR]
,[PART NUM]
,[UOM]
,[STOCK COST (RM)]
,[CAMMS TRF DATE]
,[ACTUAL TRF DATE]
,[TRF QTY]
,[TRF NUM]
,[TOTAL TRF COST (RM)]
,[TRF BY (NAME)]
,[TRF REQUESTED BY (REMARK)]
,[TRF PURPOSE (REMARK)]
 FROM qms_mmd_trf_tab  (NOLOCK)
 where Guid = @guid
 and [STATE NAME] like @state
 order by [TRF NUM]

delete from qms_mmd_trf_tab
where Guid = @guid

set nocount off

end


--Alter table qms_mmd_grn_tab
--add [STATE NAME] varchar(100)
--Alter table qms_mmd_trf_tab
--Alter column [STOCK DESCR] nvarchar(1000)
--Alter table qms_mmd_trf_tab
--Alter column [TRF REQUESTED BY (REMARK)] nvarchar(1000)
--Alter table qms_mmd_trf_tab
--Alter column [TRF PURPOSE (REMARK)] nvarchar(1000)
--Alter table qms_mmd_trf_tab
--Alter column [STOCK COST (RM)] numeric(30,4)
--Alter table qms_mmd_trf_tab
--Alter column [TOTAL TRF COST (RM)] numeric(30,4)
--Alter table qms_mmd_trf_tab
--Alter column [TRF QTY] numeric(30,4)

----Alter FUNCTION [dbo].[noofworkingdays]
----(
----    @StartDate as DATETIME, @EndDate as DATETIME
----)
----RETURNS INT
----AS
----BEGIN
    
----Declare @TotalworkDays int
----Declare @intTotalDaysNumber int 
----Declare @intTotalSundaysNumber int 
----Declare @intTotalSaturdaysNumber int 

----select @intTotalDaysNumber		= datediff(day,@StartDate,@EndDate)  
----select @intTotalSundaysNumber	=  (datediff(day, 7, @EndDate)/7 - datediff(day, 6, @StartDate)/7) 
----select @intTotalSaturdaysNumber =  (datediff(day, 6, @EndDate)/7 - datediff(day, 5, @StartDate)/7 )
----select @TotalworkDays = @intTotalDaysNumber	 -@intTotalSundaysNumber 	-@intTotalSaturdaysNumber
    
----	Return @TotalworkDays
----END

--select dbo.[noofworkingdays] ('2017-08-07','2017-08-10')

