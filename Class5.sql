--Cluster Index 
CREATE TABLE Employees
(
 Id INT,
 Name VARCHAR(50),
 Salary INT,
 Gender VARCHAR(10),
 City VARCHAR(50),
 Dept VARCHAR(50)
)
GO
INSERT INTO Employees VALUES (3,'Pranaya', 4500, 'Male', 'New York', 'IT')
INSERT INTO Employees VALUES (1,'Anurag', 2500, 'Male', 'London', 'IT')
INSERT INTO Employees VALUES (4,'Priyanka', 5500, 'Female', 'Tokiyo', 'HR')
INSERT INTO Employees VALUES (5,'Sambit', 3000, 'Male', 'Toronto', 'IT')
INSERT INTO Employees VALUES (7,'Preety', 6500, 'Female', 'Mumbai', 'HR')
INSERT INTO Employees VALUES (6,'Tarun', 4000, 'Male', 'Delhi', 'IT')
INSERT INTO Employees VALUES (2,'Hina', 500, 'Female', 'Sydney', 'HR')
INSERT INTO Employees VALUES (8,'John', 6500, 'Male', 'Mumbai', 'HR')
INSERT INTO Employees VALUES (10,'Pam', 4000, 'Female', 'Delhi', 'IT')
INSERT INTO Employees VALUES (9,'Sara', 500, 'Female', 'London', 'IT')

Select * from Employees where ID = 8

Select * from Employees Where Dept = 'IT'


Create Clustered index IX_employee_id on Employees(ID Asc)

--Non Clustered Index 
Create nonclustered index IX_Employees_Dept on Employees(Dept Asc) include([Name],[Salary],[Gender],[City])

--SubQueries
--Display All Products having Price equal to Product ML Road Tire
Use AdventureWorks2019
Select * from Production.Product where Name = 'ML Road Tire'

Select Name As ProductName
from Production.Product
Where ListPrice in (
					Select ListPrice 
					from Production.Product 
					where Name = 'ML Road Tire')


Select * into #tempData from (
Select 1 StudentId, 89 Maths , 98 English
Union ALL
Select 1 StudentId, 89 Maths , 98 English
Union All
Select 2 StudentId, 21 Maths , 34 English
Union All
Select 2 StudentId, 21 Maths , 34 English ) A

--Displaying the FirstName, LastName of all active Salesperson. 
Select FirstName,LastName
From Person.Person 
where BusinessEntityID in (
				Select BusinessEntityID 
				from HumanResources.Employee 
				where BusinessEntityID in (
										Select BusinessEntityID 
										from Sales.SalesPerson
															)
							)

--Correlated subquery
--Display First & last name of salesperson where Bonus amount  - 5000
Select P.FirstName,P.LastName,E.BusinessEntityID -- 290 Rows
From Person.Person As P
inner join HumanResources.Employee As E
on P.BusinessEntityID = E.BusinessEntityID
Where 5000.00 in (
	Select Bonus
	From Sales.SalesPerson As sp
	Where E.BusinessEntityID = sp.BusinessEntityID
)

use BatchDec03
Select * from Employees

Select Name,Salary
From Employees e
where Salary > (
			Select Avg(Salary) from Employees where Dept = E.Dept
)

Use AdventureWorks2019
Select * from Production.Product
Select * from Production.ProductSubcategory

--Display the Name of all the products where Subcategory is Wheels 
Select Name As ProductName
from Production.Product As A
where Exists (
			Select *
			From Production.ProductSubcategory As B
			Where A.ProductSubcategoryID = B.ProductSubcategoryID
			and B.Name = 'Wheels'
)


---Cte
;with cte as (
			Select 1 StudentId, 89 Maths , 98 English
			Union ALL
			Select 1 StudentId, 89 Maths , 98 English
			Union All
			Select 2 StudentId, 21 Maths , 34 English
			Union All
			Select 2 StudentId, 21 Maths , 34 English )
Select * from cte

Select * from #tempData


;with cte as
		(
		Select *,ROW_NUMBER() over (Partition by StudentId Order by StudentId) as Row_Num
		from #tempData
			)
Delete from Cte Where Row_Num>1

Select * from #tempData


--Muitple Cte
Use AdventureWorks2019
Select * from HumanResources.Employee

;With SalariedEmployee As(
        Select E.BusinessEntityID As EmployeeID,P.FirstName,P.LastName
		From HumanResources.Employee As E
		inner Join Person.Person As P
		On E.BusinessEntityID = P.BusinessEntityID
		Where E.SalariedFlag = 1
),
LongServingEmployee as (
		Select BusinessEntityID As EmployeeID,HireDate
		From HumanResources.Employee
		Where Year(GetDate())-Year(HireDate)>=5
)
Select A.*,B.HireDate
From SalariedEmployee As A
Left join LongServingEmployee As B
on A.EmployeeID = B.EmployeeID


---Pivot & Unpivot 
Select DaysToManufacture,Avg(StandardCost) As Avg_Cost
From Production.Product
Group by DaysToManufacture

Select 'Avg_Cost' as DaystoManuFacture,[0],[1],[2],[4]
from(
Select DaysToManufacture,StandardCost
From Production.Product) as SrcTbl
Pivot
(
Avg(StandardCost) for DaysToManufacture in([0],[1],[2],[4])
) As PvtTable


--Unpivot

CREATE TABLE pvt_data (VendorID INT, Emp1 INT, Emp2 INT,  
    Emp3 INT, Emp4 INT, Emp5 INT);  
GO  
INSERT INTO pvt_data VALUES (1,4,3,5,4,4);  
INSERT INTO pvt_data VALUES (2,4,1,5,5,5);  
INSERT INTO pvt_data VALUES (3,4,3,5,4,4);  
INSERT INTO pvt_data VALUES (4,4,2,5,5,4);  
INSERT INTO pvt_data VALUES (5,5,1,5,5,5); 

Select * from pvt_data


Select VendorId,Employee,Orders 
From(
Select VendorID,Emp1,Emp2,Emp3,Emp4,Emp5
From pvt_data) As P
unpivot
(
Orders for Employee in (Emp1,Emp2,Emp3,Emp4,Emp5)
) As Unpvt


--Any/All
Select Name,Salary,Dept
From Employees e
where Salary > All (
			Select Salary from Employees where Dept = 'IT'
)

Select Salary from Employees where Dept = 'IT'


Select Name,Salary,Dept
From Employees e
where Salary > Any (
			Select Salary from Employees where Dept = 'IT'
)


--View
Create View vEmployeeHireDate
As
Select E.BusinessEntityID As EmployeeID, P.FirstName,P.LastName , E.HireDate
From HumanResources.Employee As E
inner join Person.Person As P
on E.BusinessEntityID = P.BusinessEntityID


Select * from vEmployeeHireDate


update vEmployeeHireDate
Set FirstName = 'Peter'
Where EmployeeID = 285


Select * from Person.Person where BusinessEntityID = 285



--Stored Procedure 
Create Procedure GetEmployeeExp
As 
Begin
		Select *,DATEDIFF(Year,StartDate,getDate()) as YarsExp
		From HumanResources.vEmployeeDepartmentHistory
		Where EndDate is null
End

Exec GetEmployeeExp
Execute GetEmployeeExp


--Stored Procedure With Parameters

Create Procedure GetEmployeeExpParam
					@Department varchar(30),
					@Shift varchar(30)

As 
Begin
		Select *,DATEDIFF(Year,StartDate,getDate()) as YarsExp
		From HumanResources.vEmployeeDepartmentHistory
		Where EndDate is null and Department = @Department and Shift = @Shift
End


Exec GetEmployeeExpParam 'Production','Night'

---Stored Procedure With Output
Create procedure GetProdList 
					@Product Varchar(40),
					@MaxPrice Float,
					@ComparePrice Float Output,
					@ListPrice Float Output

As
Begin 
Select P.Name As ProductName,P.ListPrice 
From Production.Product As P
inner join Production.ProductSubcategory As S
on P.ProductSubcategoryID = S.ProductSubcategoryID
where S.Name like @Product and P.ListPrice<@MaxPrice

Set @ListPrice = (
			Select Max(P.ListPrice) 
			From Production.Product As P
			inner join Production.ProductSubcategory As S
			on P.ProductSubcategoryID = S.ProductSubcategoryID
			where S.Name like @Product and P.ListPrice<@MaxPrice)

Set @ComparePrice = @MaxPrice
End

Declare @SetComparePrice float, @SetListPrice Float
Execute GetProdList '%Cleaners%',700,@SetComparePrice output, @SetListPrice output

Print(@SetComparePrice)
Print(@SetListPrice)

if @SetListPrice<@SetComparePrice
Begin
		Print 'These Product Can be Purchased less than $'
		+Rtrim(Cast(@SetComparePrice as Varchar(20)))+'.'
End
Else
		Print 'Prices for all the Products in the Category exceed  $'
		+Rtrim(Cast(@SetComparePrice as Varchar(20)))+'.'

Select * from Production.ProductSubcategory


--Exception Handler 

Create table AuditLog(ErrorMessage varchar(255),
					  ErrorLine int,
					  CustomMessage varchar(100),
					  EventDate datetime2
)


Begin Try
	Delete From Production.Product
	Where ProductID = 980
End Try
Begin Catch
insert into AuditLog
		Select ERROR_MESSAGE() As Message, 
				ERROR_LINE() As ErrorlIne,
				'Foreign Key Issue' as Custom_Message, 
				GetDate() as DateTime
End Catch 

Select * from AuditLog
Select * from Employees

--Transaction 
Begin Try
		Begin Transaction
		Update Employees
		Set Salary  = 5000
		Where Gender = 'Male'
		Save Transaction MaleSalaryupdate

		Update Employees
		Set Salary = 5000/0
		Where Gender = 'Female'
		Commit Transaction
		Print 'Transaction has been Commited '
End Try
Begin Catch
	Rollback Transaction MaleSalaryupdate
	Print 'Transaction has been Rollbacked'
End Catch

Create Table AuditLog(SysMessage varchar(50),UserName varchar(50),EventDate Datetime2)


--Trigger Of Sql Server

--DML Trigger (Insert,Update<Delete)
Select * from Region_Sales

--Update
Create Trigger Trigger_Update on Region_Sales
After Update
As 
Begin
Insert Into AuditLog
			Select 'Data Has Been Updated',
			USER_NAME(),
			GetDate()

End 
Update Region_Sales
Set Units = 200
Where OrderDate = '2021-01-07'


Select * from AuditLog


--Insert Trigger
Create Trigger Trigger_Insert on Region_Sales
After Insert
As 
Begin
Insert Into AuditLog
			Select 'Data Has Been Inserted',
			USER_NAME(),
			GetDate()

End 
Insert into Region_Sales 
values ('2022-12-30','Central','Andrews','Binder',28,125,625,'Version 2')


--Delete Trigger
Create Trigger Trigger_Delete on Region_Sales
After Delete
As 
Begin
Insert Into AuditLog
			Select 'Data Has Been Delete',
			USER_NAME(),
			GetDate()

End 


Delete From Region_Sales where OrderDate = '2022-12-30'



--DDL Trigger (Applied Over Database)
Create Trigger Trigger_Create 
on Database
after Create_table
As
Begin
  Insert Into AuditLog
			Select 'Table has been Create' as SysMessage,
			USER_NAME(),
			GetDate()
End


Create Table SampleTbl(id int)


Select * from AuditLog

--Alter
Create Trigger Trigger_Alter 
on Database
after Alter_table
As
Begin
  Insert Into AuditLog
			Select 'Table has been Altered' as SysMessage,
			USER_NAME(),
			GetDate()
End

Alter Table SampleTbl
Alter Column id float

--Drop
Create Trigger Trigger_Drop
on Database
after Drop_table
As
Begin
  Insert Into AuditLog
			Select 'Table has been Droping' as SysMessage,
			USER_NAME(),
			GetDate()
End

Drop Table SampleTbl


Create table CreateLog(
EventTime Datetime2,
EventType Varchar(100),
ObjectName Varchar(100),
TSQLCommand Varchar(Max)
)


Create Trigger AuditTableCreation 
	on Database
For Create_table
as 
Begin
			Declare @data XML;
			Set @data = EVENTDATA()
			Insert into CreateLog Values (
			@data.value('(/EVENT_INSTANCE/PostTime)[1]','DATETIME'),
			@data.value('(/EVENT_INSTANCE/EventType)[1]','Varchar(100)'),
			@data.value('(/EVENT_INSTANCE/ObjectName)[1]','Varchar(100)'),
			@data.value('(/EVENT_INSTANCE/TSQLCommand)[1]','Varchar(max)')
			)
End 


Create Table Sample_table(Id int)


Select * from CreateLog


---RollUp 
Select Isnull(Dept,'All Dept') As Dept,Sum(Salary) As Salary
from Employees
Group By Rollup(Dept)


Select Isnull(Dept,'All Dept') As Dept,Isnull(Gender,'All Gender') As Gender,Sum(Salary) As Salary
from Employees
Group By Rollup(Dept,Gender)


Select Coalesce(Dept,'All Dept') As Dept,Sum(Salary) As Salary
from Employees
Group By Rollup(Dept)











