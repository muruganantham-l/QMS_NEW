ALTER proc pwo_image_upload_sp
@guid varchar(800) = '0x0a'
,@filePath varchar(800) = 'D:\QMS\PWO_IMAGE_UPLOAD_SSIS\Package\AML_ARS_SSIS\PWO_Images\CWO176902.jpg'
as
begin
set nocount ON
--select @pwo_number = 1

declare @sql Nvarchar(800)
 declare @name varchar(300)

select @name = left(right(@filePath,CHARINDEX('\',REVERSE(@filePath))-1),9)

--SELECT m.RowID from wko_mst m (nolock) where m.wko_mst_wo_no = 'CWO176902'

Set @sql='INSERT INTO wko_ref (site_cd,MST_rowid,file_name,type,status,attachment,audit_user,audit_date,column1) select ''QMS'',(SELECT m.RowID from wko_mst m (nolock) where m.wko_mst_wo_no = '''+@name+''')
,'''+@name+'.jpg'+''',''A'',''Saved'',(SELECT * FROM OPENROWSET(BULK '''+ @filePath+''', SINGLE_BLOB) AS BLOB),''SFTP SERVER''
,'''+cast(getdate() as varchar(300))+'''
,''Native'''
 exec sp_executesql  @sql
 

if exists (  SELECT '' from wko_mst m (nolock) where m.wko_mst_wo_no = @name)
BEGIN

insert  file_names ( file_name1,session_id)
SELECT @name+'.jpg',@guid

END
 

set NOCOUNT OFF
end
 