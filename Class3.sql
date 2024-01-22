---Inner Join 
Create table depts(DeptId Int Primary key,DeptName varchar(20),DeptLocation varchar(40))

INSERT INTO depts
  VALUES
  (1, 'IT','Chicago'),
  (2,'Finance','New York'),
  (3,'Sales','Seattle'),
  (4,'Marketing','Delhi'),
  (5,'HR','New York'),
  (6,'Security','New Jersey')

CREATE TABLE employee_Join
  (
      id INT PRIMARY KEY,
      name VARCHAR(50) NOT NULL,
      gender VARCHAR(50) NOT NULL,
      salary INT NOT NULL,
      DeptId INT constraint FK_key foreign key references depts(deptID)
   )

INSERT INTO employee_Join
  VALUES
  (1, 'David', 'Male', 5000, 3),
  (2, 'Jim', 'Female', 6000, 5),
  (3, 'Kate', 'Female', 7500, 1),
  (4, 'Will', 'Male', 6500, 4),
  (5, 'Shane', 'Female', 5500, 2),
  (6, 'Shed', 'Male', 8000, 3),
  (7, 'Vik', 'Male', 7200, 5),
  (8, 'Vince', 'Female', 6600, 1),
  (9, 'Jane', 'Female', 5400, 4),
  (10, 'Laura', 'Female', 6300, 2),
  (11, 'Mac', 'Male', 5700, 3),
  (12, 'Pat', 'Male', 7000, 5),
  (13, 'Julie', 'Female', 7100, 1),
  (14, 'Elice', 'Female', 6800,4),
  (15, 'Wayne', 'Male', 5000, 2),
  (16, 'Peter', 'Male', 5000, null)


  Select * from employee_Join
  Select * from Depts

  --Inner Join 
  Select emp.*,dep.DeptName,Dep.DeptLocation
  From employee_Join As emp
  inner join depts as dep
  on emp.DeptId = dep.DeptId


  --
  Use AdventureWorks2019
  Select *
  from Sales.SalesOrderHeader

  Select *
  from Sales.SalesOrderDetail

  --Apply Join on Multiple Table
  Select A.SalesOrderID,A.UnitPrice,B.OrderDate,C.Name As Product_Name,A.OrderQty
  From Sales.SalesOrderDetail As A
  inner join Sales.SalesOrderHeader As B
  On A.SalesOrderID = B.SalesOrderID
  inner join Production.Product As C
  on A.ProductID = C.ProductID


  --Left Join 
  Select emp.*,Dep.DeptName,Dep.DeptLocation
  From employee_Join As emp
  left join depts as dep
  on emp.DeptId = dep.DeptId


  --Right Join 
   Select emp.id,emp.Name,Emp.Gender,Emp.Salary,Dep.*
  From employee_Join As emp
  Right join depts as dep
  on emp.DeptId = dep.DeptId


  --Full Join 
  Select *
  From employee_Join As emp
  Full join depts as dep
  on emp.DeptId = dep.DeptId


    Select * from employee_Join
  Select * from Depts



--6*16 = 96

--Cross Join 
Select * from employee_Join cross join Depts


--- Group and Filter Data using Joins
Select Year(OrderDate) As Year,MONTH(OrderDate) As Month,Sum(OrderQty) As Total_Order,Count(Distinct C.Name) Product_Count
From Sales.SalesOrderDetail As A
inner join Sales.SalesOrderHeader As B
On A.SalesOrderID = B.SalesOrderID
inner join Production.Product As C
on A.ProductID = C.ProductID
Group by Year(OrderDate),MONTH(OrderDate)
Having Sum(OrderQty)>1000
order by Year,Month









 

 











 









