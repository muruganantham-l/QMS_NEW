truncate table pdf_images --my local database
Declare @sql nvarchar(max),@filePath nvarchar(max),@name nvarchar(max)
DECLARE EMP_CURSOR CURSOR  
LOCAL  FORWARD_ONLY  FOR  
select name,path from dbo.dir('D:\temp\BATCH7')

OPEN EMP_CURSOR  
FETCH NEXT FROM EMP_CURSOR INTO  @name ,@filePath
WHILE @@FETCH_STATUS = 0  
BEGIN   
Set @sql='INSERT INTO pdf_images (be_number,attachment) select '''+@name+''',(SELECT * FROM OPENROWSET(BULK '''+ @filePath+''', SINGLE_BLOB) AS BLOB)'
 exec sp_executesql  @sql
FETCH NEXT FROM EMP_CURSOR INTO  @name ,@filePath 
END  
CLOSE EMP_CURSOR   
deallocate EMP_CURSOR
--3756


insert cammsprod.tomms_prod.dbo.ast_ref

(

site_cd
,mst_RowID
,file_name
,type
,status
,attachment
,audit_user
,audit_date
,column1
 

)

select 'QMS'
,rowid
,p.be_number+'-KEWPA.pdf'
,'A'
,'Saved'
,p.attachment
,'QMS'
,GETDATE()
,'Native'
from cammsprod.tomms_prod.dbo.ast_mst a (nolock)
join pdf_images p (nolock)
on a.ast_mst_asset_no = p.be_number

--Latin1_General_CI_AS --test
--SQL_Latin1_General_CP1_CI_AS

SELECT
    col.name, col.collation_name
FROM 
    sys.columns col
WHERE
    object_id = OBJECT_ID('pdf_images')

	--3725 affected
	--3756
	--31

	alter table pdf_images

  ALTER COLUMN be_number
    VARCHAR(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
 



 --select * from pdf_images (nolock)

 --truncate table pdf_images

 select be_number from pdf_images where not exists (select '' from cammsprod.tomms_prod.dbo.ast_mst a (nolock) where a.ast_mst_asset_no = be_number)

  