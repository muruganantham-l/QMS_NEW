
set nocount on

if exists (select '*' from ast_mst (nolock),
ast_det (nolock)
where ast_mst.rowid = ast_det.mst_rowid
and ast_det_varchar15 in ('Purchase Biomedical','New Biomedical')
)

begin

update ast_det
set ast_det_varchar22 = 'NEW', audit_date = getdate()
from
ast_mst,
ast_det
where ast_mst.rowid = ast_det.mst_rowid
and ast_det_varchar15 in ('New Biomedical')
and ast_det_varchar22 is NULL

update ast_det
set ast_det_varchar22 = 'NEW-BE' , audit_date = getdate()
from
ast_mst,
ast_det
where ast_mst.rowid = ast_det.mst_rowid
and ast_det_varchar15 in ('New Biomedical')
and ast_det_varchar22 in ('NEW')
and convert(date,ast_det_datetime2 ) = convert(date,getdate())

update ast_det
set ast_det_varchar22 = 'PUR-EX', audit_date = getdate()
from
ast_mst,
ast_det
where ast_mst.rowid = ast_det.mst_rowid
and ast_det_varchar15 in ('Purchase Biomedical')
and ast_det_varchar22 is NULL
and convert(date,ast_det_datetime2 ) = convert(date,getdate())

update ast_det
set ast_det_varchar22 = 'EXISTING', audit_date = getdate()
from
ast_mst,
ast_det
where ast_mst.rowid = ast_det.mst_rowid
and ast_det_varchar15 in ( 'New Biomedical' , 'Purchase Biomedical' )
and ast_det_varchar22 in ('NEW-BE')
and convert(date,ast_det_datetime4 ) = convert(date,getdate())

end 

update ast_det
set ast_det_varchar22 = 'EXISTING', audit_date = getdate()
from
ast_mst,
ast_det
where ast_mst.rowid = ast_det.mst_rowid
and ast_det_varchar15 in ( 'EXISTING' )
and ast_det_varchar22 not in ('EXISTING')



set nocount off