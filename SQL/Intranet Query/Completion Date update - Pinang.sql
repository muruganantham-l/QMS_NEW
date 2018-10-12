select distinct 
asset_number
 from ppm_completion_table (nolock)
where updated = 'Yes'

update wko_det
set wko_det_cmpl_date = NULL
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO158616')
	and wko_det_cmpl_date is not null

	Delete from wko_sts 
	WHERE  site_cd ='QMS' 
	AND wko_sts_wo_no ='CWO158616' 
	AND wko_sts_status ='CMP' 

	UPDATE wko_mst with (updlock)
	SET wko_mst_status = 'OPE', audit_user = 'tomms', audit_date = getdate() 
	WHERE wko_mst_wo_no = 'CWO158616'
	AND site_cd ='QMS'


wko_det_sched_date
2017-07-31 11:30:48.173
wko_det_exc_date
2017-07-31 11:31:02.760



update wko_ls7
set wko_ls7_resp_date = '2017-09-27 13:00:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO161108')

update wko_det
set wko_det_exc_date = '2017-09-27 13:00:00.000' --2017-10-09 16:09:26.177
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO161108')


update wko_ls7
set wko_ls7_resp_date = '2017-09-27 13:00:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO161109')

update wko_det
set wko_det_exc_date = '2017-09-27 13:00:00.000' --2017-10-09 16:09:26.177
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO161109')


update wko_ls7
set wko_ls7_resp_date = '2017-09-27 13:00:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO161206')

update wko_det
set wko_det_exc_date = '2017-09-27 13:00:00.000' --2017-10-09 16:09:26.177
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO161206')




update wko_ls7
set wko_ls7_resp_date = '2017-10-06 11:00:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO160330')

update wko_det
set wko_det_exc_date = '2017-10-06 11:00:00.000' --2017-10-09 16:09:26.177
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO160330')


update wko_ls7
set wko_ls7_resp_date = '2017-08-01 15:20:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157739')

update wko_det
set wko_det_exc_date = '2017-08-01 15:20:00.000'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157739')

-----------------------------------------------------

update wko_det
set wko_det_cmpl_date = '2017-08-04 13:13:00.000' 
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157969')

update wko_ls7
set wko_ls7_resp_date = '2017-08-04 10:01:00.000'
,wko_ls7_ack_date = '2017-08-04 10:00:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157969')

update wko_det
set wko_det_exc_date = '2017-08-04 10:01:00.000'
,wko_det_sched_date = '2017-08-04 10:00:00.000'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157969')



-------------------------------------------
update wko_ls7
set wko_ls7_resp_date = '2017-07-28 16:30:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157464')

update wko_det
set wko_det_exc_date = '2017-07-28 16:30:00.000'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157464')
-----------------------------------------

update wko_det
set wko_det_cmpl_date = '2017-07-08 10:59:00.000' 
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO155873')

-----------------------------------------------------
update wko_ls7
set wko_ls7_resp_date = '2017-07-28 15:15:00.000'
,wko_ls7_ack_date = '2017-07-28 14:45:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157508')

update wko_det
set wko_det_exc_date = '2017-07-28 15:15:00.000'
,wko_det_sched_date = '2017-07-28 14:45:00.000'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157508')
-----------------------------------------------
update wko_ls7
set wko_ls7_resp_date = '2017-07-28 16:30:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157465')

update wko_det
set wko_det_exc_date = '2017-07-28 16:30:00.000'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157465')
-------------------------------------------------------

update wko_det
set wko_det_cmpl_date = '2017-07-20 10:30:00.000' 
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO156906')

-----------------------------------------------------

update wko_ls7
set wko_ls7_resp_date = '2017-08-01 08:17:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157642')

update wko_det
set wko_det_exc_date = '2017-08-01 08:17:00.000'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157642')
-----------------------------------------

update wko_ls7
set wko_ls7_resp_date = '2017-07-28 09:31:00.000'
,wko_ls7_ack_date =  '2017-07-28 09:00:00.000'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157466')

update wko_det
set wko_det_exc_date = '2017-07-28 09:31:00.000'
,wko_det_sched_date = '2017-07-28 09:00:00.000'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO157466')
-----------------------------------------------

update wko_det
set wko_det_cmpl_date = '2017-06-19 13:30:00.000' 
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO155131')

--------------------------------------------------


cf_label
where customize_label like '%Ack%'

	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in( 'PWO278131','PWO277742','PWO278322','PWO277719','PWO277755')

	sp_tables '%%'


update prm_mst with (updlock)
				--set prm_mst_lpm_date = prm_mst_next_due 
				where site_cd = 'QMS'
				and prm_mst_assetno in (select distinct 
											asset_number
											 from ppm_completion_table (nolock)
											where updated = 'Yes')
				and prm_mst_freq_code = '1'
				and prm_mst_curr_wo is NULL

update prm_mst with (updlock)
				set prm_mst_next_due = Dateadd(yy,1,prm_mst_lpm_date)
				,prm_mst_next_create = dateadd(mm,11,prm_mst_lpm_date)
				,audit_date = getdate()
				where site_cd = 'QMS'
				and prm_mst_assetno in (select distinct 
											asset_number
											 from ppm_completion_table (nolock)
											where updated = 'Yes')
				and prm_mst_freq_code = '1'
				and prm_mst_curr_wo is NULL

update prm_mst with (updlock)
				set prm_mst_lpm_date = prm_mst_next_due 
				where site_cd = 'QMS'
				and prm_mst_assetno in (select distinct 
											asset_number
											 from ppm_completion_table (nolock)
											where updated = 'Yes')
				and prm_mst_freq_code = '2'
				and prm_mst_curr_wo is NULL

update prm_mst with (updlock)
				--set prm_mst_next_due = Dateadd(mm,6,prm_mst_lpm_date)
				--,prm_mst_next_create = dateadd(mm,5,prm_mst_lpm_date)
				--,audit_date = getdate()
				where site_cd = 'QMS'
				and prm_mst_assetno = 'SBH010091'
				and prm_mst_assetno in (select distinct 
											asset_number
											 from ppm_completion_table (nolock)
											where updated = 'Yes')
				and prm_mst_freq_code = '2'
				and prm_mst_curr_wo is NULL

	
	update wko_det
	set wko_det_sc_date = '2017-9-01 00:00:00.000'
from 
	wko_det ,
	wko_mst 
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no = 'PWO292905'

		
	update wko_mst
	set wko_mst_due_date = '2017-9-30 00:00:00.000',
wko_mst_org_date = '2017-9-01 00:00:00.000'
from 
	wko_mst 
	where  wko_mst_wo_no = 'PWO292905'

	prm_mst with (updlock)
				--set prm_mst_next_due = Dateadd(mm,6,prm_mst_lpm_date)
				--,prm_mst_next_create = dateadd(mm,6,prm_mst_lpm_date)
				--,audit_date = getdate()
				where site_cd = 'QMS'
				and prm_mst_freq_code = '2'
				and prm_mst_curr_wo is NULL


update wko_ls7
set wko_ls7_resp_date = '2015-11-12 17:04'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO121893')
	and wko_ls7_level = 3

update wko_det
set wko_det_exc_date = '2015-11-12 17:04'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO121893')


update wko_ls7
set wko_ls7_resp_date = '2015-11-26 16:27'
,audit_date = getdate()
from 
wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO122832')
	and wko_ls7_level = 2

update wko_det
set wko_det_exc_date = '2015-11-26 16:27'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO122832')
	and wko_det_exc_date is NULL



update wko_det
set wko_det_cmpl_date = '2017-09-06 11:00:00.000' 
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO159820')
	and wko_det_cmpl_date = '2017-09-14 19:08:15.960'


insert into wko_ls7
([site_cd],[mst_RowID],[wko_ls7_level],[wko_ls7_emp_id],[wko_ls7_due_days],[wko_ls7_total_days],[wko_ls7_wo_org_date],[wko_ls7_due_date],[audit_user],[audit_date],[column1],[column2],[column3],[column4],[column5],[RowID],[wko_ls7_resp_date],[wko_ls7_rej_date],[wko_ls7_ack_date])
 Values ('QMS',13314,1,'HLTBME1',1,1,'Jan 11 2015 10:21PM','Jan 12 2015 10:21PM','selcc1','Jan 11 2015 10:21PM',NULL,NULL,NULL,NULL,NULL,1127,'Jan 11 2015 10:23PM',NULL,'Jan 11 2015 10:22PM')



wko_mst ,
	wko_ls7
	where wko_ls7.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO126663','CWO103066','CWO114846','CWO113655','CWO120061','CWO125589','CWO125072','CWO114942','CWO103067','CWO104225','CWO116256','CWO103316','CWO126920','CWO112735','CWO126800','CWO117508','CWO101990'
,'CWO126435','CWO114971','CWO103068','CWO112800','CWO126226','CWO126436','CWO125588','CWO103142','CWO102563','CWO125106','CWO125110','CWO118627','CWO118668','CWO117735')
	and wko_ls7_level = 2


update wko_det
set wko_det_exc_date = '2016-02-12 00:00:00.000'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO126663','CWO103066','CWO114846','CWO113655','CWO120061','CWO125589','CWO125072','CWO114942','CWO103067','CWO104225','CWO116256','CWO103316','CWO126920','CWO112735','CWO126800','CWO117508','CWO101990'
,'CWO126435','CWO114971','CWO103068','CWO112800','CWO126226','CWO126436','CWO125588','CWO103142','CWO102563','CWO125106','CWO125110','CWO118627','CWO118668','CWO117735')
	and wko_det_exc_date is NULL


scriptout wko_sts

insert into wko_sts
([site_cd],[mst_RowID],[wko_sts_wo_no],[wko_sts_status],[wko_sts_originator],[wko_sts_start_date],[wko_sts_end_date],[wko_sts_duration],[audit_user],[audit_date],[column1],[column2],[column3],[column4],[column5])
 --Values ('QMS',13440,'CWO100005','CMP','pngnc5','Jan 15 2015 12:00PM','Jan 15 2015  1:45PM',0,'PNGADM','Jan 15 2015  1:45PM',NULL,NULL,NULL,NULL,NULL,9953)
select 
[site_cd],[mst_RowID],[wko_sts_wo_no],'CMP',[wko_sts_originator],'2016-02-13 00:00:00.000' ,[wko_sts_end_date],[wko_sts_duration],[audit_user],getdate(),[column1],[column2],[column3],[column4],[column5]
from wko_sts (nolock)
where wko_sts_wo_no in ('CWO120061','CWO125589','CWO125072','CWO114942','CWO103067','CWO104225','CWO116256','CWO103316','CWO126920','CWO112735','CWO126800','CWO117508','CWO101990'
,'CWO126435','CWO114971','CWO103068','CWO112800','CWO126226','CWO126436','CWO125588','CWO103142','CWO102563','CWO125106','CWO125110','CWO118627','CWO118668','CWO117735')
and wko_sts_status = 'OPE'

CWO113655
CWO126663
CWO103066
CWO114846
	
	update wko_mst
	set wko_mst_status ='CMP' , audit_date = getdate()
	from 
	wko_mst ,
	wko_det (nolock)
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO120061','CWO125589','CWO125072','CWO114942','CWO103067','CWO104225','CWO116256','CWO103316','CWO126920','CWO112735','CWO126800','CWO117508','CWO101990'
,'CWO126435','CWO114971','CWO103068','CWO112800','CWO126226','CWO126436','CWO125588','CWO103142','CWO102563','CWO125106','CWO125110','CWO118627','CWO118668','CWO117735')
and wko_sts_status = 'OPE'


update wko_det
set wko_det_act_code = 'REPAIR',wko_det_corr_action =  'REPAIR'
,audit_date = getdate()
from
	wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO120061','CWO125589','CWO125072','CWO114942','CWO103067','CWO104225','CWO116256','CWO103316','CWO126920','CWO112735','CWO126800','CWO117508','CWO101990'
,'CWO126435','CWO114971','CWO103068','CWO112800','CWO126226','CWO126436','CWO125588','CWO103142','CWO102563','CWO125106','CWO125110','CWO118627','CWO118668','CWO117735')

----('CWO126663','CWO103066','CWO114846','CWO113655','CWO120061','CWO125589','CWO125072','CWO114942','CWO103067','CWO104225','CWO116256','CWO103316','CWO126920','CWO112735','CWO126800','CWO117508','CWO101990'
----,'CWO126435','CWO114971','CWO103068','CWO112800','CWO126226','CWO126436','CWO125588','CWO103142','CWO102563','CWO125106','CWO125110','CWO118627','CWO118668','CWO117735')


select wko_mst_wo_no ,wko_mst_org_date, wko_det_cmpl_date,wko_det_exc_date
from 
wko_mst ,
	wko_det
	where wko_det.mst_rowid = wko_mst.rowid 
	and wko_mst_wo_no in ('CWO162970'
,'CWO162889'
,'CWO162771'
,'CWO162689'
,'CWO162650'
,'CWO162648'
,'CWO162533'
,'CWO162493'
,'CWO162425'
,'CWO162423'
,'CWO162422'
,'CWO162150'
,'CWO161919'
,'CWO161766'
,'CWO161743'
,'CWO161604'
)

----="update wko_det set wko_det_cmpl_date = '"&&"' ,audit_date = getdate() from wko_mst ,	wko_det	where wko_det.mst_rowid = wko_mst.rowid	and wko_mst_wo_no in ('"&&"')"

----="update wko_ls7 set wko_ls7_resp_date = '"&&"' ,audit_date = getdate() from wko_mst ,	wko_ls7	where wko_ls7.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('"&&"')"

----="update wko_det set wko_det_exc_date = '"&&"'  ,audit_date = getdate() from wko_mst ,	wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('"&&"')"


update wko_det set wko_det_cmpl_date = '2017-10-30 17:18' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162970')
update wko_det set wko_det_cmpl_date = '2017-10-29 09:52' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162889')
update wko_det set wko_det_cmpl_date = '2017-10-27 08:15' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162771')
update wko_det set wko_det_cmpl_date = '2017-10-25 11:04' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162689')
update wko_det set wko_det_cmpl_date = '2017-10-23 11:27' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162650')
update wko_det set wko_det_cmpl_date = '2017-11-26 08:16' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162648')
update wko_det set wko_det_cmpl_date = '2017-10-19 10:21' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162533')
update wko_det set wko_det_cmpl_date = '2017-10-19 09:58' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162493')
update wko_det set wko_det_cmpl_date = '2017-10-19 10:36' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162425')
update wko_det set wko_det_cmpl_date = '2017-10-19 10:38' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162423')
update wko_det set wko_det_cmpl_date = '2017-10-19 10:39' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162422')
update wko_det set wko_det_cmpl_date = '2017-10-13 05:21' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162150')
update wko_det set wko_det_cmpl_date = '2017-10-09 12:34' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO161919')
update wko_det set wko_det_cmpl_date = '2017-10-08 11:38' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO161766')
update wko_det set wko_det_cmpl_date = '2017-10-05 03:49' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO161743')
update wko_det set wko_det_cmpl_date = '2017-10-05 14:34' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO161604')


update wko_ls7 set wko_ls7_resp_date = '2017-10-27 16:20' ,audit_date = getdate() from wko_mst , wko_ls7 where wko_ls7.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO163023')
update wko_ls7 set wko_ls7_resp_date = '2017-10-27 14:25' ,audit_date = getdate() from wko_mst , wko_ls7 where wko_ls7.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO163011')
update wko_ls7 set wko_ls7_resp_date = '2017-10-26 04:30' ,audit_date = getdate() from wko_mst , wko_ls7 where wko_ls7.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162972')
update wko_ls7 set wko_ls7_resp_date = '2017-10-26 02:07' ,audit_date = getdate() from wko_mst , wko_ls7 where wko_ls7.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162967')
update wko_ls7 set wko_ls7_resp_date = '2017-10-20 16:32' ,audit_date = getdate() from wko_mst , wko_ls7 where wko_ls7.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162647')
update wko_ls7 set wko_ls7_resp_date = '2017-10-10 12:51' ,audit_date = getdate() from wko_mst , wko_ls7 where wko_ls7.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162073')

update wko_det set wko_det_exc_date = '2017-10-27 16:20'  ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO163023')
update wko_det set wko_det_exc_date = '2017-10-27 14:25'  ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO163011')
update wko_det set wko_det_exc_date = '2017-10-26 04:30'  ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162972')
update wko_det set wko_det_exc_date = '2017-10-26 02:07'  ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162967')
update wko_det set wko_det_exc_date = '2017-10-20 16:32'  ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162647')
update wko_det set wko_det_exc_date = '2017-10-10 12:51'  ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162073')

update wko_det set wko_det_cmpl_date = '2017-10-25 09:30:00.000' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO161604')
update wko_ls7 set wko_ls7_resp_date = '2017-10-24 09:48:00.000' ,wko_ls7_ack_date = '2017-10-22 12:01:00.960' ,audit_date = getdate() from wko_mst , wko_ls7 where wko_ls7.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162073')
update wko_det set wko_det_exc_date = '2017-10-24 09:48:00.000' ,wko_det_sched_date = '2017-10-22 12:01:00.960' ,audit_date = getdate() from wko_mst , wko_det where wko_det.mst_rowid = wko_mst.rowid and wko_mst_wo_no in ('CWO162626')


