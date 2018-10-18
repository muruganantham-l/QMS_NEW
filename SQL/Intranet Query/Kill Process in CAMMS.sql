-- sp_who2

-- selcc2


-- kill 123                 
-- prm_det

DECLARE @v_spid INT

DECLARE Users CURSOR 

FAST_FORWARD FOR

SELECT SPID

FROM master.dbo.sysprocesses (NOLOCK)

WHERE spid>50

AND status='sleeping'

AND DATEDIFF(mi,last_batch,GETDATE())>= 30 --Check sleeping connections that exists before 60 min..

AND spid<>@@spid

OPEN Users

FETCH NEXT FROM Users INTO @v_spid

WHILE (@@FETCH_STATUS=0)

BEGIN

PRINT 'KILLing '+CONVERT(VARCHAR,@v_spid)+'...'

EXEC('KILL '+@v_spid)

FETCH NEXT FROM Users INTO @v_spid

END

CLOSE Users

DEALLOCATE Users


--sp_stored_procedures '%bill%'

--sp_billing_report_out;1
--sp_billing_report_purcahse_out;1
--sp_billing_report_summary_out;1

--             

DECLARE @sql NVARCHAR(max) = ''

SELECT @sql = CONCAT(@sql, 'kill ' , session_id, CHAR(13))
FROM sys.dm_exec_requests 
WHERE status = 'suspended'

EXEC(@sql)

select @sql
