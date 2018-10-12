
create table Uptime_KPI_Day_mst
(Begroup varchar(100),
minage int ,
maxage int,
Firstlevel int,
Secondlevel int
)

Insert into Uptime_KPI_Day_mst 
Select 'CR' , 0 , 5 ,244 , 199
union all 
Select 'PS' , 0 , 5 ,237 , 199
union all 
Select 'BA' , 0 , 5 ,231 , 199

Insert into Uptime_KPI_Day_mst 
Select 'CR' , 6 , 10 ,237 , 199
union all 
Select 'PS' , 6 , 10 ,233 , 199
union all 
Select 'BA' , 6 , 10 ,226 , 199


Insert into Uptime_KPI_Day_mst 
Select 'CR' , 11 , 15 ,233 , 199
union all 
Select 'PS' , 11 , 15 ,225 , 199
union all 
Select 'BA' , 11 , 15 ,221 , 199


Insert into Uptime_KPI_Day_mst 
Select 'CR' , 16 , 999 ,0 , 0
union all 
Select 'PS' , 16 , 999 ,0 , 0
union all 
Select 'BA' , 16 , 999 ,0 , 0