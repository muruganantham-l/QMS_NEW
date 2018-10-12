Alter FUNCTION [dbo].[state_noofworkingdays]
(
    @statename varchar(100),@StartDate as DATETIME, @EndDate as DATETIME
)
RETURNS INT
AS
BEGIN
    
Declare @TotalworkDays int
Declare @intTotalDaysNumber int 
Declare @intTotalSundaysNumber int 
Declare @intTotalSaturdaysNumber int 

if @statename = 'JOHOR'
	begin 
		select @intTotalDaysNumber		= datediff(day,@StartDate,@EndDate)  
		select @intTotalSundaysNumber	=  (datediff(day, 5, @EndDate)/7 - datediff(day, 4, @StartDate)/7) 
		select @intTotalSaturdaysNumber =  (datediff(day, 6, @EndDate)/7 - datediff(day, 5, @StartDate)/7 )
		select @TotalworkDays = @intTotalDaysNumber	 -@intTotalSundaysNumber 	-@intTotalSaturdaysNumber
	end
else
	begin
		select @intTotalDaysNumber		= datediff(day,@StartDate,@EndDate)  
		select @intTotalSundaysNumber	=  (datediff(day, 7, @EndDate)/7 - datediff(day, 6, @StartDate)/7) 
		select @intTotalSaturdaysNumber =  (datediff(day, 6, @EndDate)/7 - datediff(day, 5, @StartDate)/7 )
		select @TotalworkDays = @intTotalDaysNumber	 -@intTotalSundaysNumber 	-@intTotalSaturdaysNumber
	end   
	Return @TotalworkDays
END

Alter FUNCTION [dbo].[state_noofholidays]
(
    @statename varchar(100),@StartDate as DATETIME, @EndDate as DATETIME
)
RETURNS INT
AS
BEGIN
    
Declare @TotalworkDays int
Declare @intTotalDaysNumber int 
Declare @intTotalSundaysNumber int 
Declare @intTotalSaturdaysNumber int 

if @statename = 'JOHOR'
	begin 
		select @intTotalSundaysNumber	=  (datediff(day, 5, @EndDate)/7 - datediff(day, 4, @StartDate)/7) 
		select @intTotalSaturdaysNumber =  (datediff(day, 6, @EndDate)/7 - datediff(day, 5, @StartDate)/7 )
		select @TotalworkDays = @intTotalSundaysNumber 	+ @intTotalSaturdaysNumber
	end
else
	begin
		
		select @intTotalSundaysNumber	=  (datediff(day, 7, @EndDate)/7 - datediff(day, 6, @StartDate)/7) 
		select @intTotalSaturdaysNumber =  (datediff(day, 6, @EndDate)/7 - datediff(day, 5, @StartDate)/7 )
		select @TotalworkDays = @intTotalSundaysNumber 	+ @intTotalSaturdaysNumber
	end   
	Return @TotalworkDays
END
