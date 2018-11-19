Select
wkr_mst_wr_no 'WR Number', 
FORMAT( wkr_mst_org_date,'dd/MM/yyyy hh:mm:ss')	 'WR Date',
wkr_mst_taken_by 'WR Taken by',
FORMAT( wkr_mst_due_date,'dd/MM/yyyy hh:mm:ss')	   'WR Due date',
wkr_mst_assetno 'WR Asset No',
wkr_mst_wr_status 'WR Status',
wkr_mst_chg_costcenter 'WR Cost center',
wkr_mst_location 'State' ,
wkr_mst_work_area 'Circle' ,
wkr_mst_assetlocn 'District' ,
wkr_mst_create_by 'Created BY' ,
wkr_det_approver 'Approver Code',
FORMAT( wkr_det_appr_date,'dd/MM/yyyy hh:mm:ss')	  'Approve Date',
wkr_det_wo 'CWO Number',
wkr_det_varchar1 'Clinic Type',
wkr_det_varchar2 'Clinic category',
wkr_det_varchar4 'Zone',
wkr_det_varchar8 'Ownership',
wkr_det_cus_code 'Clinic Code',
Replace(Replace(wkr_det_note1,char(13),''),char(10),'')  'Clinic Name',
Replace(Replace(wkr_det_varchar3,char(13),''),char(10),'')  'Clinic Address'
from
wkr_mst (nolock),
Wkr_det (nolock) 
 Where wkr_mst.site_cd = Wkr_det.site_cd
 and wkr_mst.rowid = Wkr_det.mst_rowid
 and wkr_mst_org_date BETWEEN '2018-01-01' and '2018-11-19'