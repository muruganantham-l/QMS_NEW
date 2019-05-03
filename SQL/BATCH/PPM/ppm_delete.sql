update cnt_mst WITH ( UPDLOCK ) 
SET cnt_mst_counter =cnt_mst_counter -1
WHERE site_cd ='QMS' AND cnt_mst_module_cd ='PM'

delete m
from prm_mst m   where--join prm_det d on m.RowID = d.mst_RowID and 
m.prm_mst_assetno in (
'PRK031958'
)

delete d 
from prm_mst m join prm_det d on m.RowID = d.mst_RowID and m.prm_mst_assetno in (
'PRK031958'
)

update perak_ppm_list set lpm_date = '2018-07-01' where be_number = 'PRK031958'

