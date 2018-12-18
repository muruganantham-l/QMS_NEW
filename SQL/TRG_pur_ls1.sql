IF OBJECT_ID('TRG_pur_ls1') IS NOT NULL
DROP TRIGGER TRG_pur_ls1
GO

CREATE TRIGGER TRG_pur_ls1 
ON dbo.pur_ls1
AFTER INSERT AS
BEGIN
set nocount on
declare @sysdate date = getdate()
--INSERT INTO EMPLOYEE_BACKUP
if  exists(
SELECT '*'
FROM   INSERTED i
join   wko_mst w (NOLOCK) on w.wko_mst_wo_no = i.pur_ls1_wo_no
join   ast_mst  m (NOLOCK) on w.wko_mst_assetno = m.ast_mst_asset_no
join   ast_det d (NOLOCK) on m.RowID = d.mst_RowID
join   extended_warrenty_by_supplier_tbl e (NOLOCK) 
on e.BE_GRP_CODE = m.ast_mst_asset_grpcode
and d.ast_det_varchar24 = e.Supplier_Code
and @sysdate BETWEEN ast_det_warranty_date AND dateadd(MONTH,e.EXTENDED_WARNTY_MONTH,ast_det_warranty_date)
and ast_det_varchar15 in ('New Biomedical','Purchase Biomedical')
UNION
SELECT '*'
FROM   INSERTED i
join   wko_mst w (NOLOCK) on w.wko_mst_wo_no = i.pur_ls1_wo_no
join   ast_mst  m (NOLOCK) on w.wko_mst_assetno = m.ast_mst_asset_no
join   ast_det d (NOLOCK) on m.RowID = d.mst_RowID
  and @sysdate BETWEEN ast_det_datetime1 AND ast_det_warranty_date
and ast_det_varchar15 in ('New Biomedical','Purchase Biomedical')
)

begin 
delete m from pur_ls1 m join INSERTED i on m.mst_RowID = i.RowID
delete d from pur_mst m join INSERTED i on m.RowID = i.RowID join pur_det d on m.RowID = d.mst_RowID
delete m from pur_mst m join INSERTED i on m.RowID = i.RowID


RAISERROR('BE Asset Under Warranty by Supplier',16,1);RETURN

END
set nocount OFF
END 