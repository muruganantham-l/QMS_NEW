 
 delete from additional_equipment_list
insert additional_equipment_list
(
month_year
,state1
,district
,clinic
,be_number
,be_category
,serial_number
,manufacturer
,model
,start_service_date
,purchase_cost
,maintenance_rate
,monthly_fee
,extra1
,extra2


)

select 
'01/08/2018'
,state
,district
,[clinic code]
,[be number]
,[be category]
,[serial number]
,manufacturer
,model
,'01/09/2018'
,[purchase cost]
,[Maiuntenance Rate]
,[monthly maint cost (rm)]
,[purchasing date]
,[clinic code]

from   [clinic]