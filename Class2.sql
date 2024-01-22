--Where Clause
Select * From Region_Sales where Region = 'East'
Select * From Region_Sales where Region in ('East','West')

Select * From Region_Sales where Region = 'North'


--AND
Select * 
from Region_Sales 
where Region = 'East' and item = 'Pencil'


--OR
Select * 
from Region_Sales 
where Region = 'East' Or item = 'Pencil'


--Not Operator
Select * from Region_Sales Where not item in ('Pencil','Pen') and not Region = 'East'
Select * from Region_Sales Where  item <> 'Pencil'
Select * from Region_Sales Where  item != 'Pencil'


---And/OR/NOt
Select * from Region_Sales where (Item = 'Pencil' or Item  = 'Pen') and Region = 'East' and not Units>10


--Union
Select * from Region_Sales -- 43 rows With Version2
Select * From Region_Sales1 -- 41 rows With Version1 and 2 rows with Version 2



--union
--Columns in Both the Select should be Same 
--ordering of Columns Should be in the same manner 


Select * from Region_Sales
union
Select * From Region_Sales1


Select * into combineResult from (
Select * from Region_Sales
union
Select * From Region_Sales1) A

Select * from combineResult order by OrderDate Asc


--union All 
Select *,'Table 1' as Dataset from Region_Sales
union All
Select *, 'Table 2' as Dataset From Region_Sales1

--Intersect
Select *  from Region_Sales
Intersect
Select * From Region_Sales1


--Except
Select *  from Region_Sales
Except
Select * From Region_Sales1

--like 
--StartWith 
Select Distinct Name from [AdventureWorks2019].[Production].[Product] where Name like 'Lock%'
--End With
Select Distinct Name from [AdventureWorks2019].[Production].[Product] where Name like '%Wheel'
--Contains 
Select Distinct Name from [AdventureWorks2019].[Production].[Product] where Name like '%Rear%'

--Display All rows Where Second letter in Rep is 'o'
Select *  from Region_Sales where Rep like '__O%'

Select * from Region_Sales where OrderDate between '2021-01-01' and '2021-06-30'
Select * from Region_Sales where units between 10 and 50
Select * from Region_Sales where Rep between 'Andrews' and 'Jones'


--Region & Item Wise revenue 
Select Region,Item,Sum(Total) As Total_rev
from Region_Sales
Where Item  = 'Pencil'
Group By Region, Item


Select Region,Item,Sum(Total) As Total_rev
from Region_Sales
Group By Region, Item
having Sum(Total) >1000


Select Region,Item,Sum(Total) As Total_rev
from Region_Sales
Group By Region, Item
having Sum(Total) >1000
order by Total_rev 


----Temp Table 

Select Region,Item,Sum(Total) As Total_rev
into #TempRegionItem
from Region_Sales
Group By Region, Item


Select Region,Item,Sum(Total) As Total_rev
into ##TempRegionItem
from Region_Sales
Group By Region, Item

Select * from ##TempRegionItem 

Select  @@VERSION


























