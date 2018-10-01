USE [tomms_prod]
GO

/****** Object:  Trigger [dbo].[Tr_DB_Audit_ast_mst]    Script Date: 1/10/2018 11:12:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[Tr_DB_Audit_ast_mst] ON [dbo].[ast_mst] FOR INSERT, UPDATE, DELETE
AS

DECLARE @bit INT ,
       @field INT ,
       @maxfield INT ,
       @char INT ,
       @fieldname VARCHAR(128) ,
       @TableName VARCHAR(128) ,
       @PKCols VARCHAR(1000) ,
       @sql VARCHAR(2000), 
       @UpdateDate VARCHAR(21) ,
       @UserName VARCHAR(128) ,
       @Type CHAR(1) ,
       @PKSelect VARCHAR(1000)


--You will need to change @TableName to match the table to be audited
SELECT @TableName = 'ast_mst'

-- date and user
SELECT         @UserName = SYSTEM_USER ,
       @UpdateDate = CONVERT(VARCHAR(8), GETDATE(), 112) 
               + ' ' + CONVERT(VARCHAR(12), GETDATE(), 114)

-- Action
IF EXISTS (SELECT * FROM inserted)
       IF EXISTS (SELECT * FROM deleted)
               SELECT @Type = 'U'
       ELSE
               SELECT @Type = 'I'
ELSE
       SELECT @Type = 'D'

-- get list of columns
SELECT * INTO #ins FROM inserted
SELECT * INTO #del FROM deleted

-- Get primary key columns for full outer join
SELECT @PKCols = COALESCE(@PKCols + ' and', ' on') 
               + ' i.' + c.COLUMN_NAME + ' = d.' + c.COLUMN_NAME
       FROM    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk ,

              INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
       WHERE   pk.TABLE_NAME = @TableName
       AND     CONSTRAINT_TYPE = 'PRIMARY KEY'
       AND     c.TABLE_NAME = pk.TABLE_NAME
       AND     c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME

-- Get primary key select for insert
SELECT @PKSelect = COALESCE(@PKSelect+'+','') 
       + '''<' + COLUMN_NAME 
       + '=''+convert(varchar(100),
coalesce(i.' + COLUMN_NAME +',d.' + COLUMN_NAME + '))+''>''' 
       FROM    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk ,
               INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
       WHERE   pk.TABLE_NAME = @TableName
       AND     CONSTRAINT_TYPE = 'PRIMARY KEY'
       AND     c.TABLE_NAME = pk.TABLE_NAME
       AND     c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME

IF @PKCols IS NULL
BEGIN
       RAISERROR('no PK on table %s', 16, -1, @TableName)
       RETURN
END

SELECT         @field = 0, 
       @maxfield = MAX(ORDINAL_POSITION) 
       FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName
WHILE @field < @maxfield
BEGIN
       SELECT @field = MIN(ORDINAL_POSITION) 
               FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = @TableName 
               AND ORDINAL_POSITION > @field
       SELECT @bit = (@field - 1 )% 8 + 1
       SELECT @bit = POWER(2,@bit - 1)
       SELECT @char = ((@field - 1) / 8) + 1
       IF SUBSTRING(COLUMNS_UPDATED(),@char, 1) & @bit > 0
                                       OR @Type IN ('I','D')
       BEGIN
               SELECT @fieldname = COLUMN_NAME 
                       FROM INFORMATION_SCHEMA.COLUMNS 
                       WHERE TABLE_NAME = @TableName 
                       AND ORDINAL_POSITION = @field

					  
					   -- select @PKSelect


               SELECT @sql = '
insert Audit (    Type, 
               TableName, 
               PK, 
               FieldName, 
               OldValue, 
               NewValue, 
               UpdateDate, 
               UserName)
select ''' + @Type + ''',''' 
       + @TableName + ''',' + @PKSelect
       + ',''' + @fieldname + ''''
       + ',convert(varchar(1000),d.' + @fieldname + ')'
       + ',convert(varchar(1000),i.' + @fieldname + ')'
       + ',''' + @UpdateDate + ''''
       + ',''' + @UserName + ''''
       + ' from #ins i full outer join #del d'
       + @PKCols
       + ' where i.' + @fieldname + ' <> d.' + @fieldname 
       + ' or (i.' + @fieldname + ' is null and  d.'
                                + @fieldname
                                + ' is not null)' 
       + ' or (i.' + @fieldname + ' is not null and  d.' 
                                + @fieldname
                                + ' is null)' 
               EXEC (@sql)


			   if @fieldname in ('ast_mst_asset_locn','ast_mst_asset_longdesc')
			   begin

			    select @PKSelect   = 'convert(varchar(100),coalesce(i.RowID,d.RowID))'

			   declare @xml nvarchar(max),@body nvarchar(max)
			   ,@fieldname1 varchar(100) = @fieldname,@guid  varchar(800) = newid()

			   select @fieldname1  = case   @fieldname1 when 'ast_mst_asset_locn' then 'District' when 'ast_mst_asset_longdesc' then 'Be Category' else null end

			   SET @body ='<html><body font="Calibri">
					<div align="Left">
					<h2>
					Dear Admin, </h2>
					<p>
					This is to inform you that, the '+@fieldname1+' has been changed by ' +SUSER_NAME()+'. Please refer the below detail information.
					</p>
					</div><H4>'+@fieldname1+' Status Update Info :</H4>
					<table border = 1> 
					<tr>
					<th  > BE Number </th> <th>  Field Name </th> <th> Old Value </th> <th> New Value </th> <th> Update date </th> <th> Username </th>
					
					</tr>'    



			     SELECT @sql = '
insert Audit1 (    Type, 
               TableName, 
               PK, 
               FieldName, 
               OldValue, 
               NewValue, 
               UpdateDate, 
               UserName
			    ,sessiod_id
			   
			   )
select ''' + @Type + ''',''' 
       + @TableName + ''',' + @PKSelect
       + ',''' + @fieldname + ''''
       + ',convert(varchar(1000),d.' + @fieldname + ')'
       + ',convert(varchar(1000),i.' + @fieldname + ')'
       + ',''' + @UpdateDate + ''''
       + ',''' + @UserName + ''''
	     + ',''' + @guid + ''''
       + ' from #ins i full outer join #del d'
       + @PKCols
       + ' where i.' + @fieldname + ' <> d.' + @fieldname 
       + ' or (i.' + @fieldname + ' is null and  d.'
                                + @fieldname
                                + ' is not null)' 
       + ' or (i.' + @fieldname + ' is not null and  d.' 
                                + @fieldname
                                + ' is null)' 
               EXEC (@sql)

   if (select count(*) from  Audit1 where  sessiod_id = @guid  ) > 0 
   begin

			   SET @xml = CAST(( SELECT a.ast_mst_asset_no AS 'td'
			   ,'',case   S.FieldName when 'ast_mst_asset_locn' then 'District' when 'ast_mst_asset_longdesc' then 'Be Category' else '' end AS 'td'
			   ,'',isnull(s.OldValue,'') AS 'td'
			   ,'',isnull(S.newvalue,'') AS 'td'
			   ,'',S.updatedate AS 'td'
			   ,'',S.username AS 'td'
			  -- ,'', SUSER_NAME() AS 'td'
        FROM	Audit1 s
		join    ast_mst a (nolock)
		on      a.RowID = s.pk
		where sessiod_id = @guid 
		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))
		 
		delete Audit1 where sessiod_id = @guid 
		 
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


				declare @subject varchar(300) = @fieldname1+' Change found on Asset Register'

				EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Email Notification', -- replace with your SQL Database Mail Profile 
		@body = @body,
		@subject = @subject ,
		@body_format ='HTML',
		@recipients = 'muruganantham@qms.com.my;misadmin@qms.com.my',
		@importance = 'HIGH'
		 end
			   end

       END

	   
END
GO


