Select
wkr_mst_wr_no 'WR Number', 
wkr_mst_org_date 'WR Date Time',
wkr_mst_assetno 'BE Number',
wkr_mst_location 'State' ,
wkr_mst_assetlocn 'District' ,
wkr_mst_create_by 'Created By' ,
wkr_det_cus_code 'Clinic Code',
Replace(Replace(wkr_det_note1,char(13),''),char(10),'')  'Clinic Name'
from wkr_mst (nolock),
Wkr_det (nolock) 
Where wkr_mst.site_cd = Wkr_det.site_cd
and wkr_mst.rowid = Wkr_det.mst_rowid