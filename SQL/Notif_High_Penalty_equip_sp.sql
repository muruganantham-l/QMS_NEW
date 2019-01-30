ALTER Procedure Notif_High_Penalty_equip_sp
as
begin

	Declare @Email_code varchar(200), 
			@Zm_email_code varchar(200)--,@State_name varchar(200)
	, @agm_email_code  varchar(200) --= 'pramodan@qms.com.my'
	--alter table email_user_mst add agm_email_code varchar(100)
	--update email_user_mst set agm_email_code = 'pramodan@qms.com.my'  where State_name in ('johor','melaka')
	DECLARE cursor_name CURSOR 	
	for 
	Select 
	Distinct Email_code , 
			Zm_email_code --, State_name
			,agm_email_code
	from 
	email_user_mst (nolock)
	--where Zm_email_code = 'sekar.suppiah@qms.com.my'

	OPEN cursor_name  

FETCH NEXT FROM cursor_name   
INTO @Email_code, @Zm_email_code,@agm_email_code-- ,@State_name

WHILE @@FETCH_STATUS = 0  

    BEGIN
		DECLARE @LogonTriggerData xml ,
		@LoginName varchar(50),
		@state varchar(100) = 'JOHOR'

		DECLARE @xml NVARCHAR(MAX)
		DECLARE @body NVARCHAR(MAX)

       
		SET @xml = CAST(( SELECT ROW_NUMBER ( ) OVER ( order by ast_mst_ast_lvl, wko_mst_wo_no  ) AS 'td','', wko_mst_wo_no AS 'td','',convert(varchar, wko_mst_org_date, 120) AS 'td','', wkr_mst_wr_no AS 'td','',convert(varchar, wkr_mst_org_date, 120) AS 'td','

',
			   wko_mst_assetno AS 'td','', ast_mst_asset_longdesc AS 'td','',wko_det_assign_to AS 'td','' ,wko_det_customer_cd AS 'td','',ast_mst_asset_locn AS 'td','', ast_mst_ast_lvl AS 'td'
        FROM 
			wko_mst (nolock),
			wko_det (nolock),
			wkr_mst (nolock),
			ast_mst (nolock),
			email_user_mst (nolock)
			WHERE wko_mst.rowid = wko_det.mst_rowid
			and wko_mst.site_cd =    wko_det.site_cd
			and wko_mst.site_cd =    wkr_mst.site_cd
			and ast_mst.site_cd =    wkr_mst.site_cd
			and wkr_mst.wkr_mst_wr_no = wko_det.wko_det_wr_no 
			and wko_mst.wko_mst_assetno = wkr_mst.wkr_mst_assetno 
			and ast_mst_asset_no    = wko_mst_assetno
			and ast_mst_asset_grpcode in ('10-792' , '10-792N','11-165' , '11-165N','13-746' , '13-746N','ME-009' , 'ME-009N','15-976','DE-032' , 'DE-032N','15-938','DE-008', 'DE-008N','16-885' , '16-885N','12-025' , '12-025N')
			and ast_mst_ast_lvl    = email_user_mst.State_name
			and Email_code = @Email_code
			and Zm_email_code = @Zm_email_code
			and wko_mst_status = 'OPE'
			--added by murugan
		--	and ast_mst_ast_lvl = @State_name
			and datediff(dd,wkr_mst_org_date ,getdate()) >=5
			order by ast_mst_ast_lvl
		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


		SET @body ='<html><body font="Calibri">
					<div align="Left">
					<h2>
					Dear State Manager, </h2>
					<p>
					This is system generated BE Category CWO Pending "Notification" for High Penalty Equipment Monitoring. 
					<br />
					<br />
					We seek your attention to follow up and complete the same on High Priority. 
					<br />
					<br />
					Below table contain all CWO Pending more than 5 days.
					<br />
					<br />
					</p>
					</div><H4>CWO Pending Info :</H4>
					<table border = 1> 
					<tr>
					<th> No </th> <th> WO Number </th> <th> WO Date </th> <th> WR Number </th> <th> WR Date </th> <th> BE Number </th> <th> Be Category </th> <th> WO Assigned To </th> <th> Clinic Code </th> <th> District </th> <th> State Name </th> </tr>'    

 
		SET @body = @body + @xml +'</table><div align="Left"><br />
				<br />
				</div>
				<div align="Center">
				<p>*Note : This is a system generated email.Please do not reply.</p>
				</div>
				</div></body></html>'
			
		Declare @sub varchar(500)
		Select @sub = Concat( @state , ' - Monitoring High Penalty equipment CWO pending more than 5 days')
		--pramodan@qms.com.my
		set @Zm_email_code = CONCAT(@Zm_email_code,';'+ @agm_email_code)

		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Email Notification', -- replace with your SQL Database Mail Profile 
		@body = @body,
		@subject = 'Monitoring High Penalty equipment',
		@body_format ='HTML',
		@recipients =@Email_code,-- 'muruganantham@qms.com.my',--  @Email_code,
		@copy_recipients = @Zm_email_code,-- 'sekar.suppiah@qms.com.my;muruganantham@qms.com.my',--'muruganantham@qms.com.my',-- @Zm_email_code,
		@blind_copy_recipients = 'muruganantham@qms.com.my',
		@importance = 'HIGH'
		
		
	FETCH NEXT FROM cursor_name INTO @Email_code,@Zm_email_code,@agm_email_code  -- ,@State_name
        END  

    CLOSE cursor_name  
    DEALLOCATE cursor_name  


end


