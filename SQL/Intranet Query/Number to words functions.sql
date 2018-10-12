 
CREATE    Function dbo.fConvertDigit(@decNumber decimal)
returns varchar(6)
as
Begin
declare
@strWords varchar(6)
            Select @strWords = Case @decNumber
                When '1' then 'One'
                When '2' then 'Two'
                When '3' then 'Three'
                When '4' then 'Four'
                When '5' then 'Five'
                When '6' then 'Six'
                When '7' then 'Seven'
                When '8' then 'Eight'
                When '9' then 'Nine'
                Else ''
            end
return @strWords
end
 

 
CREATE    Function dbo.fConvertTens(@decNumber varchar(2)) 
returns varchar(30) 
as 
Begin 
declare 
@strWords varchar(30) 
-- If amt is between 10 and 19
If Left(@decNumber, 1) = 1  
begin 
 Select @strWords = Case @decNumber 
     When '10' then 'Ten' 
     When '11' then 'Eleven' 
     When '12' then 'Twelve' 
     When '13' then 'Thirteen' 
     When '14' then 'Fourteen' 
     When '15' then 'Fifteen' 
     When '16' then 'Sixteen' 
     When '17' then 'Seventeen' 
     When '18' then 'Eighteen' 
     When '19' then 'Nineteen' 
 end 
end 
else  -- if amt is between 20 and 99
begin 
 Select @strWords = Case Left(@decNumber, 1) 
     When '0' then ''   
     When '2' then 'Twenty ' 
     When '3' then 'Thirty ' 
     When '4' then 'Forty ' 
     When '5' then 'Fifty ' 
     When '6' then 'Sixty ' 
     When '7' then 'Seventy ' 
     When '8' then 'Eighty ' 
     When '9' then 'Ninety ' 
 end 
 Select @strWords = @strWords + dbo.fConvertDigit(Right(@decNumber, 1)) 
end 
 --Convert ones place digit. 
  
return @strWords 
end 
 
 
CREATE Function dbo.fConvertHundreds (@decNumber varchar(3)) 
returns varchar(200) 
as  
Begin 
declare @strWords varchar(200) 
 
 Select @strWords = Case left(@decNumber,1) 
     When '1' then 'One' 
     When '2' then 'Two' 
     When '3' then 'Three' 
     When '4' then 'Four' 
     When '5' then 'Five' 
     When '6' then 'Six'  
     When '7' then 'Seven' 
     When '8' then 'Eight' 
     When '9' then 'Nine' 
     Else '' 
 end 
  
 if ltrim(rtrim(@strWords)) <> '' and @strWords is not null 
  select @strWords = @strWords + ' Hundred '+ dbo.fconvertTens(right(@decNumber,2)) 
 else 
  select @strWords = dbo.fconvertTens(right(@decNumber,2)) 
  
return @strWords 
end 
 
--Finally, I created the function to convert amount less than 999,999,999.99 to words using above 3 functions. The basic concepts used are follows.
--If the input amt contains decimal (.), then take two numbers after decimal and convert them to words using fConvertTens() function.
--If the input amt contains 3 or less characters before decimal, then the amt will be less than 1000, so, use fConvertHundreds() function.
--If the input amt contains 4 to 6 characters before decimal, then amt in words will contain thousand parts and hundred parts only. Use fConvertHundreds() for final 3 numbers to calculate hundreds part and numbers before that to calculate thousand parts.
--If the input amt contains 7 to 9 characters before decimal, then amt in words will contain million part, thousand part and hundred part. Use fConvertHundreds() for final 3 numbers to calculate hundreds part, and 3 numbers before that to calculate thousands part and remaining numbers before 6 numbers to calculate million part.
 

CREATE function dbo.fNumToWords
(@decNumber decimal(12, 2)) 
returns varchar(300) 
As 
Begin 
Declare 
 @strnum varchar(100), 
 @strCents varchar(100), 
 @strWords varchar(300), 
 @intIndex integer 
 
 
Select @strnum = Cast(@decNumber as varchar(100)) 
Select @intIndex = CharIndex('.', @strnum) 
select @strCents = '' 
 
if(@decNumber>999999999.99) 
BEGIN  
 RETURN '' 
END 
 
If @intIndex > 0  
begin 
 Select @strCents = dbo.fConvertTens(Right(@strnum, Len(@strnum) - @intIndex)) 
 Select @strnum = SubString(@strnum, 1, Len(@strnum) - 3) 
 If Len(@strCents) > 0 Select @strCents = @strCents + ' Cents' 
end 
 
declare @trail_zeros  varchar(3) 
declare @strthousands varchar(3) 
declare @strMillions varchar(3) 
 
set @trail_zeros = '000' 
 
if len(@strnum) <= 3 
begin 
 select @strWords = dbo.fConvertHundreds(left(@trail_zeros,3-len(right(@strnum,3)))+ right(@strnum,3)) 
end  
if len(@strnum) >= 4 and len(@strnum) <=6 
begin 
 select @strthousands = left(@trail_zeros,3 - len(left(right(@strnum,6),len(@strnum)-3))) + left(right(@strnum,6),len(@strnum)-3) 
 select @strWords = dbo.fConvertHundreds(@strthousands) + ' Thousand ' + dbo.fConvertHundreds(left(@trail_zeros,3-len(right(@strnum,3)))+ right(@strnum,3)) 
end 
if len(@strnum) >= 7 and len(@strnum) <=9 
begin 
 select @strMillions = left(@trail_zeros,3-len(left(@strnum,len(@strnum)-6))) + left(@strnum,len(@strnum)-6) 
 select @strthousands = left(right(@strnum,6),3) 
 select @strWords = dbo.fConvertHundreds(@strMillions) + ' Million ' + dbo.fConvertHundreds(@strthousands) + ' Thousand ' + dbo.fConvertHundreds(left(@trail_zeros,3-len(right(@strnum,3)))+ right(@strnum,3)) 
end 
 
if @strCents <> '' 
 select @strWords = @strWords + ' and ' + @strCents + ' Only' 
else 
 select @strWords = @strWords + ' Only' 
 
return  @strWords 
 
end 

select dbo.fNumToWords (1112220.15)