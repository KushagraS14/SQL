Select * from region_Sales

---Avg Function 
--Display Avg_Rev at Region & Item Level
Select Region,Item,Avg(Total) as Avg_Total
From Region_Sales
Group by Region,Item


--Display the No of Reps in Each Region
--Count()
Select Region,Count(Distinct Rep) As Rep_Count
From Region_Sales
group by Region 

Select Region,Count_Big(Distinct Rep) As Rep_Count
From Region_Sales
group by Region 


--MIN & MAX VALUES 
--Display the Min and Max Prices of Each Item
Select Item,Min(Unit_Cost) As Min_Price,Max(Unit_Cost) as Max_Price
From Region_Sales
Group by Item

--display the Total Revenue at Region & Item level
Select Region,Item,Sum(Total) as Avg_Total
From Region_Sales
Group by Region,Item


--CheckSum()
Select CHECKSUM_AGG(Units) As Unit_Check --113/86
From Region_Sales

update Region_Sales
set Units  = 100
where OrderDate = '2021-01-07'


Select Item,STDEV(Unit_Cost) As SampleStd, STDEVP(Unit_Cost) As StdPOP
from Region_Sales
Group by Item


Select Item,Var(Unit_Cost) As SampleStd, VarP(Unit_Cost) As StdPOP
from Region_Sales
Group by Item


Select DATEFROMPARTS(2020,12,16)


Select * into #TempTabe from(
Select 2020 As Year,11 As Month, 09 as Day
union
Select 2021 As Year,12 As Month, 08 as Day) A

--Create Date Out of Year, Month and Day
Select *,DATEFROMPARTS(year,Month,Day) As DateCol
from #TempTabe

--Addint time
Select DATETIME2FROMPARTS(2020,12,16,12,24,56,45,7)

--Add offset to Datetime 
Select DATETIMEOFFSETFROMPARTS(2020,12,16,12,24,56,45,5,30,7)

--time 
Select TIMEFROMPARTS(12,24,56,0,0)

---Day, Month & year
Select *,Day(OrderDate) as DayCol,Month(OrderDate) As MonthCol, Year(OrderDate) As YearCol
from Region_Sales

--Today's Date 
select GetDate()

Select OrderDate,DateAdd(DAY,7,OrderDate) As DateAfterAWeek,
				 DateAdd(Month,1,OrderDate) As DateAfterAMonth,
				 DateAdd(Year,1,OrderDate) As DateAfterAyear,
				 DateAdd(Day,-1,OrderDate) As BackDate
From Region_Sales

--Date Difference
Select DateDiff(year,'1991-12-14',getdate())

Select OrderDate,DATEDIFF(Day,OrderDate,getDate()) as Aging ,
					DATEDIFF(Month,OrderDate,getDate()) as AgingMon,
					DATEDIFF(Year,OrderDate,getDate()) as AgingYear
From Region_Sales


Exec sp_rename 'dbo.employees.Name','EmpName','Column';


--Format 
Select OrderDate,FORMAT(OrderDate,'dd-MM-yyyy') As NewFor,
				FORMAT(OrderDate,'dd-MMM-yyyy') As NewFor,
				FORMAT(OrderDate,'dd-MMM-yy') As NewFor
From  Region_Sales


--Datepart
Select OrderDate,
	   DATEPART(QQ,OrderDate) As Quarter,
	   Datepart(Dy,OrderDate) As Day_Of_year,
	   Datepart(DW,OrderDate) As Day_of_Week,
	   Datepart(WEEK,OrderDate) As WeekNum
From Region_Sales

--DateName
Select OrderDate,DateName(WEEKDAY,OrderDate) As DayName
From Region_Sales


--String Function
Select *,Len(Item) As Item_Len
From Region_Sales

Select *,CONCAT(Region,',',Item,',',Rep) as NewCol
From Region_Sales

Select *,CONCAT_WS('|',Region,Item,Rep) as NewCol
From Region_Sales



--Trim Function 
Select * into #TempName from(
Select ' Vikas' as name 
Union 
Select ' Ajay' as Name
Union
Select 'Kevin' as Name
Union
Select '     James' as Name) A

Select *,len(Name),LTRIM(Name) As NewName,len(LTRIM(Name)),RTRIM(Name) as NewLen,
Trim(Name) As TrimName
from #TempName

Update #TempName
Set Name = Trim(Name)

Select * from #TempName

Select *,REPLACE(Item,'Set','Drive') NewItem from Region_Sales


Select *,REPLACE(Item,'Set','Drive') NewItem from Region_Sales




Select 'malayalam' as Lang,REVERSE('malayalam') as ReverseStr


Select *,REVERSE(Item) As RevItem
From Region_Sales


--SubString()
Select 'Sumit Singh',SUBSTRING('Sumit Singh',1,5)


Select * into #TempTable from(
Select 'Sumit Singh' As Name
union 
Select 'Vibhor Mittal'
Union
Select 'Sachin Tendulkar') A



Select *,
	len(Name) as NameLen,
	CHARINDEX(' ',Name) as SpaceIndex,
	CHARINDEX(' ',Name)+1 as lastNameStart,
	len(Name) - CHARINDEX(' ',Name) as LastNameLen,
	SUBSTRING(Name,CHARINDEX(' ',Name)+1,len(Name) - CHARINDEX(' ',Name)) as LastName
from #TempTable

Select *,upper(Item) as UpperItem,Lower(Item) as LowerItem from 
Region_Sales

select Ascii(Substring('Sumit',3,1))


--Mathematical Functions
Select *,LOG10(Total) as Log_total
From Region_Sales

Select SQUARE(23)
Select Abs(-1009)

Select CEILING(234.56)
Select Floor(234.56)
Select Round(234.5634553,4)
Select Power(5,2)



--Cast/ Convert 
Select *,Cast(Unit_Cost as Int) as Unit_Cost_int,Convert(Int, Unit_Cost) as Unit_cost_Con
From Region_Sales

Select *,ROW_NUMBER() over (Partition by Item Order by Unit_cost desc) as Row_Num,
Rank() over (Partition by Item Order by Unit_cost desc) as ranking,
Dense_rank() over (Partition by Item Order by Unit_cost desc) as DenseRank
from Region_Sales

Select Item,Sum(Units) As Tot_Rev
Into #ItemTemp
From Region_Sales
Group by Item

Select * from #ItemTemp


Select A.*,B.Tot_Rev,(Cast(Units as Float)/cast(Tot_Rev as float)) *100
from Region_Sales As A
Left Join #ItemTemp As B
On A.Item = B.Item

Select *,Sum(Units) over (Partition by Item) As Sum_Item,
			cast(Units as Float)/Sum(Units) over (Partition by Item)*100
From Region_Sales


----Ntile 
sELECT *, NTILE(4) OVER(PARTITION BY REGION ORDER BY ORDERDATE)
FROM Region_Sales


--VARIABLE 
Declare @id int 
set @id = 1
Declare @Name varchar(10)  = 'Vikas'

Select * from Employee  where EmployeeID = @id

GO
--Scalar values Function 
Create Function AddtionOfNumber(@no1 int,@no2 int,@no3 int)
returns int
As
Begin
	return(@no1+@no2+@no3)
End

Select [dbo].[AddtionOfNumber](2,6,9)

Select * into #tempTbl from(
Select 2 As No1,4 As No2,5 as No3
Union
Select 4 As No1,6 As No2,8 as No3
union 
Select 6 As No1,9 As No2,10 as No3) A


Select *, [dbo].[AddtionOfNumber](no1,No2,No3) as Col from #tempTbl where [dbo].[AddtionOfNumber](no1,No2,No3)>18



---table valued 
Create function regionWiseSales(@Region Varchar(20))
returns table
As
Return(
	sELECT * FROM Region_Sales WHERE Region = @Region
)


sELECT * FROM [dbo].[regionWiseSales]('EAST','pENCIL')


----Find exact differnce between two Dates
DECLARE @StartDate DATE = '2022-01-01';
DECLARE @EndDate DATE = '2023-12-31';

-- Calculate the difference in years, months, and days
DECLARE @YearsDifference INT, @MonthsDifference INT, @DaysDifference INT;

-- Calculate the difference in years
SET @YearsDifference = DATEDIFF(YEAR, @StartDate, @EndDate);

-- Calculate the difference in months
SET @MonthsDifference = DATEDIFF(MONTH, DATEADD(YEAR, @YearsDifference, @StartDate), @EndDate);

-- Calculate the difference in days
SET @DaysDifference = DATEDIFF(DAY, DATEADD(MONTH, @MonthsDifference, DATEADD(YEAR, @YearsDifference, @StartDate)), @EndDate);

PRINT 'Difference: ' 
    + CAST(@YearsDifference AS VARCHAR) + ' years, ' 
    + CAST(@MonthsDifference AS VARCHAR) + ' months, ' 
    + CAST(@DaysDifference AS VARCHAR) + ' days';




select * into #temptableMarks from (
Select 1 StudentId, 89 Maths , 98 English
Union ALL
Select 1 StudentId, 89 Maths , 98 English
Union All
Select 2 StudentId, 21 Maths , 34 English
Union All
Select 2 StudentId, 21 Maths , 34 English ) A

Select * from #temptableMarks


































































