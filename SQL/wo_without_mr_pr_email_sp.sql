ALTER proc wo_without_mr_pr_email_sp
as
begin
set nocount on

declare @wr_date date  = dateadd(dd,-6,getdate())
,@sysdate date = getdate()
 
 
declare @wr_temp table
(
 no 							int  
,wo_number 						varchar(100)
,wr_number 						varchar(100)
,wr_date 						varchar(100)
,wo_date						varchar(100)
,be_number 						varchar(100)
,be_category 					varchar(100)
,repair_days					varchar(100)
,wo_assigned_to 				varchar(100)
,clinic_name					varchar(300)
,district 						varchar(100)
,state_name 					varchar(100)
,wo_status						varchar(100)
,email_id						nvarchar(max)
,pend_days						int
,circle_email_id				varchar(100)
,technician_email_id			varchar(100)
,state_mgr_email_id				varchar(100)
,zone_mgr_email_id				varchar(100)
)

insert @wr_temp
(
wo_number
,wr_number
,be_number
,wo_assigned_to
,wr_date
,repair_days
,pend_days
,circle_email_id
,technician_email_id
,wo_date
,clinic_name
,district
,state_name
)

SELECT	 m.wko_mst_wo_no
		,d.wko_det_wr_no
		,m.wko_mst_assetno
		,d.wko_det_assign_to
		,format(r.wkr_mst_org_date,'dd/MM/yyyy hh:mm:ss')	
		,DATEDIFF(dd,r.wkr_mst_org_date,@sysdate)
		,DATEDIFF(dd,d.wko_det_exc_date,@sysdate) - 1
		,d.wko_det_approver+'@qms.com.my'
		,d.wko_det_assign_to+'@qms.com.my'
		,format(m.wko_mst_org_date,'dd/MM/yyyy hh:mm:ss')
		,d.wko_det_note1 'clinicname'
		,m.wko_mst_asset_location 'district'
		,m.wko_mst_asset_level 'state'
FROM	wko_mst m (NOLOCK)
JOIN	wko_det d (NOLOCK)
on		m.RowID = d.mst_RowID
join    wkr_mst r (NOLOCK)
on		r.wkr_mst_wr_no = d.wko_det_wr_no
AND		d.wko_det_cmpl_date	is null
AND		d.wko_det_exc_date >= @wr_date

delete from @wr_temp where pend_days not in (3,7)
 
update t
set		t.be_category	=	ast_mst_asset_longdesc
from	@wr_temp t
JOIN	ast_mst	m	(NOLOCK)
on		m.ast_mst_asset_no	=	t.be_number
JOIN	ast_det d (NOLOCK)
ON		m.RowID = d.mst_RowID


update t
SET
state_mgr_email_id  = e.email_code
from email_user_mst e (NOLOCK)
join @wr_temp t on e.State_name = t.state_name


update t
SET
zone_mgr_email_id	= e.Zm_email_code	
from email_user_mst e (NOLOCK)
join @wr_temp t on e.State_name = t.state_name
where pend_days >= 7
 
 

 declare  @circle_email_id			varchar(200)	
		 ,@technician_email_id		varchar(200)
		 ,@state_mgr_email_id		varchar(200)
		 ,@zone_mgr_email_id		varchar(200)
		 ,@state					varchar(200)
		 ,@recipients				varchar(2000)		 
	
	DECLARE cursor_name CURSOR 	
	for 
	Select 
	Distinct state_mgr_email_id , 
			zone_mgr_email_id  
			,state_name
 
	from  @wr_temp
 

	OPEN cursor_name  

FETCH NEXT FROM cursor_name   
INTO @state_mgr_email_id, @zone_mgr_email_id ,@state

WHILE @@FETCH_STATUS = 0  

    BEGIN
		DECLARE @LogonTriggerData xml ,
		@LoginName varchar(50)
		--,		@state varchar(100)  
	 
		set @circle_email_id = (
SELECT (STUFF((
        SELECT '; ' + circle_email_id
        FROM (SELECT DISTINCT circle_email_id from  @wr_temp
        WHERE state_name = @state) t
        FOR XML PATH('')
        ), 1, 2, '')
    ) AS StringValue )

	set @technician_email_id = (
SELECT (STUFF((
        SELECT '; ' + technician_email_id
        FROM (SELECT DISTINCT technician_email_id from  @wr_temp
        WHERE state_name = @state) t
        FOR XML PATH('')
        ), 1, 2, '')
    ) AS StringValue )
	 

set	 @recipients = CONCAT(@circle_email_id,';',@technician_email_id,';',@state_mgr_email_id)

		DECLARE @xml NVARCHAR(MAX)
		DECLARE @body NVARCHAR(MAX)
 		
       set @xml = CAST(( SELECT ROW_NUMBER ( ) OVER ( order by wo_number  ) AS 'td',''
								, wo_number AS 'td',''
								,convert(varchar, wo_date, 120) AS 'td',''
								, wr_number AS 'td','',convert(varchar, wr_date, 120) AS 'td',''
								, be_number AS 'td',''
								, be_category AS 'td','', repair_days AS 'td',''
								,pend_days as 'td',''
								,wo_assigned_to AS 'td','' ,clinic_name AS 'td','',district AS 'td','', state_name AS 'td'

        FROM 
	   @wr_temp
	   where state_name = @state
	    
	   FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

	 

		SET @body ='<html><body font="Calibri">
					<div align="Left">
					<h2>
					Dear State Manager, </h2>
					<p>
					This is system generated BE Category CWO Pending "Notification" for USM WO without Material or Service request . 
					<br />
					<br />
					We seek your attention to follow up and complete the same on High Priority. 
					<br />
					<br />
					Below table contain all CWO Pending.
					<br />
					<br />
					</p>
					</div><H4>CWO Pending Info :</H4>
					<table border = 1> 
					<tr>
					<th> No </th> <th> WO Number </th> <th> WO Date </th> <th> WR Number </th> <th> WR Date </th> <th> BE Number </th> <th> Be Category </th> 
					<th> Repair Days </th> <th> Pending Days </th>
					<th> WO Assigned To </th> <th> Clinic Code </th> <th> District </th> <th> State Name </th> </tr>'    

 
		SET @body = @body + @xml +'</table><div align="Left"><br />
				<br />
				</div>
				<div align="Center">
				<p>*Note : This is a system generated email.Please do not reply.</p>
				</div>
				</div></body></html>'
			
		Declare @sub varchar(500)
		Select @sub = Concat( @state , ' - USM WO without Material or Service request')

		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Email Notification', -- replace with your SQL Database Mail Profile 
		@body = @body,
		@subject = @sub,--'Monitoring High Penalty equipment',
		@body_format ='HTML',
		@recipients = @recipients ,-- @Email_code,-- 'muruganantham@qms.com.my',--  @Email_code,
		@copy_recipients = @zone_mgr_email_id,-- 'sekar.suppiah@qms.com.my;muruganantham@qms.com.my',--'muruganantham@qms.com.my',-- @Zm_email_code,
		@blind_copy_recipients = 'muruganantham@qms.com.my',
		@importance = 'HIGH'
		
		
	FETCH NEXT FROM cursor_name INTO @state_mgr_email_id, @zone_mgr_email_id ,@state -- ,@State_name
        END  

    CLOSE cursor_name  
    DEALLOCATE cursor_name  


set nocount OFF
end

go 

--exec wo_without_mr_pr_email_sp