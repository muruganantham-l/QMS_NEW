ALTER proc be_pbr_pr_notification_sp
as
begin
set nocount on
DECLARE @xml NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)
declare @sysdate date = getdate()

 

set @xml=
cast(
(
SELECT isnull(w.wko_mst_assetno,'') as 'td','',isnull(m.pur_mst_porqnnum,'') as 'td','',isnull(m.pur_mst_status,'') as 'td','',isnull(l1.pur_ls1_wo_no,'') as 'td',''
,isnull(l1.pur_ls1_po_no,'') as 'td' 
from   pur_mst m (NOLOCK) 
join pur_ls1 l1 (NOLOCK)
on m.RowID = l1.mst_RowID
join wko_mst w on w.wko_mst_wo_no = l1.pur_ls1_wo_no
join ast_mst_trigger a (NOLOCK) on a.benumber = w.wko_mst_assetno
and  cast(a.modifieddate as date) = @sysdate
and m.pur_mst_status in ('RFQ','PRE','AGM')
FOR XML PATH('tr'), ELEMENTS
)
AS NVARCHAR(MAX))

SET @body ='<html><body font="Calibri">
					<div align="Left">
					<h2>
					Dear MMD, </h2>
					<p>
					This is to inform the below PR Numbers are required to be ‘Cancel’ due to 
					BE Asset has been BER (Beyond Economical Repair). Please take immediate action.
					</p>
					</div><H4>PR Info :</H4>
					<table border = 1> 
					<tr>
					<th bgcolor="#FFFF00"> BE Number </th> <th bgcolor="#FFFF00"> PR Number </th> <th bgcolor="#FFFF00"> PR Status </th> <th bgcolor="#FFFF00"> WO Number </th> <th bgcolor="#FFFF00"> PO Number </th> </tr>'    

	SET @body = @body + @xml +'</table><div align="Left"><br />
				Regards <br />
				MIS Team ,<br />
				Quantum Medical Solutions
				<br />
				</div>
				<div align="Center">
				<p>*Note : This is a system generated email.Please do not reply.</p>
				</div>
				</div></body></html>'
			
	if @xml is not null
	begin	 
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Email Notification', -- replace with your SQL Database Mail Profile 
		@body = @body,
		@subject = 'PR Numbers to required to be Cancel',
		@body_format ='HTML',
		@recipients = 'muruganantham@qms.com.my;mmd@qms.com.my',
		@importance = 'HIGH'				
    END
 --ast_mst
set nocount OFF
end


