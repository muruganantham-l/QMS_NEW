
update d SET wko_det_varchar10 = ast_det_varchar24
 from wko_mst m join wko_det d on m.RowID = d.mst_RowID
and d.wko_det_varchar10 is   null
join ast_mst a on a.ast_mst_asset_no = m.wko_mst_assetno
join ast_det e on e.mst_RowID = a.RowID
and e.ast_det_varchar15 in ('Purchase Biomedical','New Biomedical')