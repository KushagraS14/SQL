/** Purpose: Learning Database
	Date: 2023-12-03 **/
--Creating a new Database
Create Database BatchDec03

Use BatchDec03

Drop Database BatchDec03

--Creation of a new table 
Create table Employee(EmployeeID int,
					  EmpName varchar(50),
					  Salary float,
					  Department Varchar(50),
					  DOJ date,
					  Pancard char(10),
					  Age tinyint)

Select * from Employee

---inserting Data into Table
insert into Employee Values (1,'Peter',2345565.788,'Marketing','2020-01-04','ABCDE1234K',34)

--Multiple Rows insertion 
insert into Employee Values (1,'Peter',2345565.788,'Marketing','2020-01-04','ABCDE1234K',34),
							(2,'Sam',2345565.788,'Sales','2020-01-04','ABCDE1234P',32)

--Mapping Insertion
insert into Employee Values (1,'Peter',2345565.788,'2020-01-04','ABCDE1234K',34)

insert into Employee(EmployeeID,EmpName,Salary,Doj,Pancard,Age) 
Values (1,'Peter',2345565.788,'2020-01-04','ABCDE1234K',34)

--Not Null Constraint

Create table Employee_NN(EmployeeID int not null,
					  EmpName varchar(50) not null,
					  Salary float not null,
					  Department Varchar(50),
					  DOJ date not null)

Insert Into Employee_NN values(1,'Sumit',23455.565,'Sales','2023-09-01')
Insert Into Employee_NN values(1,'Sumit',null,'Sales','2023-09-01')

Select * from Employee_NN

---unique
Create table Employee_Unique(EmployeeID int unique ,
					  EmpName varchar(50) ,
					  Salary float ,
					  Department Varchar(50),
					  DOJ date )

Insert Into Employee_Unique values(1,'Sumit',23455.565,'Sales','2023-09-01')
Insert Into Employee_Unique values(2,'Sam',23455.565,'Marketing','2023-09-01')
Insert Into Employee_Unique values(null,'Sam',23455.565,'Marketing','2023-09-01')

Select * from Employee_Unique

--Primary Key
Create table Employee_PK(EmployeeID int Primary Key ,
					  EmpName varchar(50) ,
					  Salary float ,
					  Department Varchar(50),
					  DOJ date )

Insert Into Employee_PK values(1,'Sumit',23455.565,'Sales','2023-09-01')
Insert Into Employee_PK values(1,'Sumit',23455.565,'Sales','2023-09-01')
Insert Into Employee_pk values(null,'Sam',23455.565,'Marketing','2023-09-01')


Create table Product(
ProductName varchar(20),
PackSize varchar(20),
Price float
Primary Key(ProductName,PackSize)
)


Insert into Product values('Pepsi','2L',100.00)
Insert into Product values('Coke','2L',100.00)
Insert into Product values('Coke',null,100.00)

Select * from Product

--Foreign Key Constraint
Create Table Dept(Deptid int Primary key, DeptName varchar(50))

Create table Employee_Fk(
EmpId int Primary key,
EmpName varchar(50),
Salary int,
Deptid int foreign key references Dept(Deptid)
)

Insert into Dept  values (100,'IT'),
			     (101,'Sales'),
				 (102,'Marketing')

Insert into Employee_Fk values(1,'Sam',10000,100)
Insert into Employee_Fk values(2,'Sam',10000,103) -- Error
Insert into Employee_Fk values(2,'Sam',10000,null)
Insert into Employee_Fk values(3,'Sam',10000,null)

Delete from Dept where Deptid =100

Select * from Dept
Select * from Employee_Fk


---Check Constraint 
Create table Employee_Check(EmployeeID int Primary Key ,
					  EmpName varchar(50) check(len(Empname)>3 and len(Empname)<20) ,
					  Salary float check(salary>=10000),
					  Department Varchar(50),
					  DOJ date )

Insert Into Employee_Check values(2,'ab',10000,'Sales','2023-09-01')

--Default 
Create table Employee_default(EmployeeID int Primary Key ,
					  EmpName varchar(50)  ,
					  Salary float check(salary>=10000),
					  Department Varchar(50) default 'Trainee',
					  DOJ date )

insert into Employee_default values(1,'Sam',10000,null,'2023-09-01')

insert into Employee_default (EmployeeID,EmpName,Salary,DOJ) values(2,'Sam',10000,'2023-09-01')


Select * 
from Employee_default



----Practice Table 

CREATE TABLE employees
  (
      id INT ,
      name VARCHAR(50) NOT NULL,
      gender VARCHAR(50) NOT NULL,
      salary INT NOT NULL,
      department VARCHAR(50) NOT NULL
   )

INSERT INTO employees
  VALUES
  (1, 'David', 'Male', 5000, 'Sales'),
  (2, 'Jim', 'Female', 6000, 'HR'),
  (3, 'Kate', 'Female', 7500, 'IT'),
  (4, 'Will', 'Male', 6500, 'Marketing'),
  (5, 'Shane', 'Female', 5500, 'Finance'),
  (6, 'Shed', 'Male', 8000, 'Sales'),
  (7, 'Vik', 'Male', 7200, 'HR'),
  (8, 'Vince', 'Female', 6600, 'IT'),
  (9, 'Jane', 'Female', 5400, 'Marketing'),
  (10, 'Laura', 'Female', 6300, 'Finance'),
  (11, 'Mac', 'Male', 5700, 'Sales'),
  (12, 'Pat', 'Male', 7000, 'HR'),
  (13, 'Julie', 'Female', 7100, 'IT'),
  (14, 'Elice', 'Female', 6800,'Marketing'),
  (15, 'Wayne', 'Male', 5000, 'Finance')


--All column from Table 
Select * 
from employees

--Select Specific Columns 
Select Id,Name 
from employees

--Top (Limiting number of Rows )
Select top 5 * 
from employees


--Distinct
Select Distinct department,Gender From employees

--Alter Command
--Add column
--Modify Column
--Drop


Select * from employees

Alter Table employees
Add age tinyint

--Modify a column
alter table employees
alter Column Salary Float not null 


--Drop a col 
Alter table employees
Drop Column Age


Exec sp_rename 'dbo.employees.Name','EmpName','Column';


Select * from employees

--Update Manually 
Update employees
Set Age = 24
where id  = 1


--JOin 
Select * into EmpAge from (
Select 2 as id, 25 as age
union
Select 3 as id, 26 as age
union 
Select 4 as id, 27 as age
union
Select 5 as id, 28 as age
union
Select 6 as id, 29 as age
union
Select 7 as id, 30 as age
union
Select 8 as id, 25 as age
union
Select 9 as id, 19 as age
union
Select 10 as id, 50 as age) A


Select * from EmpAge


--Join 
update employees
set Age  = B.age
From employees As A
inner join EmpAge As B
on A.Id = B.id


Select * from employees

--Update top 5 rows 
update top(5) employees
Set salary = 10000


Update employees
Set Salary = Salary+salary*0.10
where id in (1,4,6,7,8)


Select * into employees_1 from employees

Update employees_1



--Merge 
--Merge Statement 
CREATE TABLE SourceProducts(
    ProductID		INT,
    ProductName		VARCHAR(50),
    Price			DECIMAL(9,2)
)


INSERT INTO SourceProducts(ProductID,ProductName, Price) VALUES(1,'Table',100),
																(2,'Desk',80),
																(3,'Chair',50),
																(4,'Computer',300)

CREATE TABLE TargetProducts(
    ProductID		INT,
    ProductName		VARCHAR(50),
    Price			DECIMAL(9,2)
)

INSERT INTO TargetProducts(ProductID,ProductName, Price) VALUES(1,'Table',100),
																(2,'Desk',180),
																(5,'Bed',50),
																(6,'Cupboard',300)
Select * from SourceProducts
Select * from TargetProducts


Merge TargetProducts As Target
using SourceProducts As Source
on Source.productId = Target.ProductID
--insert
when not Matched by Target then 
			insert(ProductID,ProductName, Price)
			values(Source.ProductID,Source.ProductName,Source.Price)
--Update
When matched then update
			set Target.Price = Source.price,
		        Target.ProductName = Source.ProductName
--Delete
When Not Matched by Source then
Delete;

---Delete
--Drop
--Truncate 
Select * from employees

Delete from employees where id = 15
Truncate table employees

--Drop 
Drop Table Employees

Select * from employees






























