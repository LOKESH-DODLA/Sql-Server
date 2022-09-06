use AssignmentDB;

-- Assignment 5

--  This steps are used to delete already existed functions, stored Procedures etc etc 
IF OBJECT_ID('dbo.fn_AddTwoNumbers') IS NOT NULL 
BEGIN
 DROP FUNCTION dbo.fn_AddTwoNumbers;
END;
GO 
-- 1. Create a user-defined function called dbo.fn_AddTwoNumbers that accepts two integer parameters.Return the value that is the sum of the two numbers. Test the function.


create function dbo.fn_AddNumbers (@FN int, @SN int)
returns int 
as 
begin
 return @FN + @SN;
end
go

select dbo.fn_AddNumbers(10, 20);


-- 2. Create a user-defined function called dbo.Trim that takes a VARCHAR(250) parameter. This function should trim off the spaces from both the beginning and the end of the string. Test the function.

if OBJECT_ID('dbo.Trim') is not null
begin
 drop function dbo.Trim;
end
go

create function dbo.trim (@sentense varchar(250))
returns varchar(250)
as
begin 
 return ltrim(rtrim(@sentense));
end
go

select '*' + dbo.trim('     testing  ') + '*';

-- 3. Create a function dbo.fn_RemoveNumbers that removes any numeric characters from a VARCHAR(250)

if OBJECT_ID('dbo.fn_RemoveNumbers') is not null
begin
 drop function dbo.fn_RemoveNumbers;
end 
go

create function dbo.fn_RemoveNumbers (@Expression VARCHAR(250))
RETURNS VARCHAR(250) 
AS 
BEGIN
 DECLARE @NewExpression VARCHAR(250) = '';
 DECLARE @Count INT = 1;
 DECLARE @Char CHAR(1);
 WHILE @Count <= LEN(@Expression) 
 BEGIN
 SET @Char = SUBSTRING(@Expression,@Count,1);
 IF ISNUMERIC(@Char) = 0 
 BEGIN
 SET @NewExpression += @Char;
 END
 SET @Count += 1;
 END;
 RETURN @NewExpression;
END;
GO
SELECT dbo.fn_RemoveNumbers('abc 123 baby you and me'); 
select dbo.fn_RemoveNumbers('123456789 Just Complete');

-- 4 .Write a function called dbo.fn_FormatPhone that takes a string of ten numbers. The function will format the string into this phone number format: “(###) ###-####.” Test the function. 

if object_id('dbo.fn_FormatPhone') is not null
begin
 drop function dbo.fn_FormatPhone;
end
go

create function dbo.fn_FormatPhone  (@Phone varchar(10))
RETURNS VARCHAR(14) 
AS 
BEGIN
 DECLARE @NewPhone VARCHAR(14);
 SET @NewPhone = '(' + SUBSTRING(@Phone,1,3) + ') ';
 SET @NewPhone = @NewPhone + SUBSTRING(@Phone,4,3) + '-';
 SET @NewPhone = @NewPhone + SUBSTRING(@Phone,7,4)
 RETURN @NewPhone;
END;
GO
SELECT dbo.fn_FormatPhone('5555551234');
