create table be_grp_image
	  (
	  group_code varchar(25)
	  ,filename  varchar(100)
	  ,image1  image
	  )
		
insert be_grp_image (group_code,filename)
select   DISTINCT m.ast_mst_asset_grpcode,r.file_name--,r.attachment 
from ast_mst m join ast_det d on m.RowID = d.mst_RowID join ast_ref r on m.RowID =r.mst_RowID where 

--ast_det_varchar21 in ('Batch 1')--,'Batch 2','Batch 3','Batch 4','Batch 5','Batch 6','Batch 7')
 ast_det_varchar15 in (
'Purchase Biomedical',
'New Biomedical'
)
and r.file_name like '%.jpg'
	
update t
	  set image1 = r.attachment
	  from ast_ref r (NOLOCK) join be_grp_image t on t.filename = r.file_name


-- Update existing, add missing
MERGE INTO dbo.ast_ref AS t
USING  (select m.RowID,a.filename,a.image1 from be_grp_image a join ast_mst m on m.ast_mst_asset_grpcode = a.group_code) as s
        ON t.mst_RowID = s.RowID
		and t.file_name = s.filename
 
WHEN NOT MATCHED THEN 
      INSERT (site_cd, mst_RowID, file_name,type,status,attachment,audit_user,audit_date,column1)
      VALUES ('QMS',s.RowID,s.filename,'P','Saved',s.image1,'tomms',getdate(),'Native');


