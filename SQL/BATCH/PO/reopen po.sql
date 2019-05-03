SELECT * from puo_mst where puo_mst_po_no = 'po116612'

--OP

SELECT m.* from puo_mst m join puo_det d on m.RowID = d.mst_RowID
and m.puo_mst_po_no = 'po116485'


update m set m.puo_mst_clo_date = null,m.puo_mst_status ='OP' from puo_mst m join puo_det d on m.RowID = d.mst_RowID
and m.puo_mst_po_no = 'po116485'

SELECT * from puo_ls2 where puo_ls2_varchar1 = 'PO117251'
insert puo_ls2 (site_cd,mst_RowID,puo_ls2_varchar1,puo_ls2_varchar2,puo_ls2_varchar3,puo_ls2_datetime1,audit_user,audit_date)
SELECT 'QMS',46695,'po116485','OP','mmdexec4',getdate(),'patch',getdate()


update p set puo_ls2_datetime2 = getdate() from puo_ls2 p where puo_ls2_varchar1 = 'po116485' and puo_ls2_varchar2 = 'cl'
 

 