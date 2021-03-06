


-- test one

-- CREATING TABLES

CREATE DATABASE TEST
USE TEST
DROP DATABASE TEST

CREATE TABLE Employee
(
  Id	INT PRIMARY KEY,
  Name	VARCHAR(20),
  Gender	VARCHAR(20),
  Basic		INT,
  HR	INT,
  DA	INT,
  TAX	INT,
  DeptID	INT FOREIGN KEY REFERENCES Department(DeptID)
 );

 CREATE TABLE Department
 (
   DeptID	INT PRIMARY KEY,
   DeptName	VARCHAR(20),
   DeptHeadID	INT
  );

  CREATE TABLE EmployeeAttendance
  (
	EmpID	INT FOREIGN KEY REFERENCES Employee(Id),
	[DATE]	DATE,
	WorkingDays	INT,
	PresentDays	INT
	);


--- INSERTING DATA


 INSERT INTO Employee
 VALUES(1,'Anil', 'Male', 10000,5000,1000,400,1);

 
 INSERT INTO Employee
 VALUES(2,'Sanjana', 'Female', 12000,6000,1000,500,2);

 
 INSERT INTO Employee
 VALUES(3,'Johnny', 'male', 5000,2500,500,200,3);

 
 INSERT INTO Employee
 VALUES(4,'Suresh', 'male', 6000,3000,500,250,1);

 
 INSERT INTO Employee
 VALUES(5,'Anglia', 'Female', 11000,5500,1000,500,4);

 
 INSERT INTO Employee
 VALUES(6,'Saurabh', 'Male', 12000,6000,1000,600,1);

 
 INSERT INTO Employee
 VALUES(7,'Manish', 'Male', 4000,2000,500,150,2);

 
 INSERT INTO Employee
 VALUES(8,'Neeraj', 'Male', 5000,2500,500,200,3);

 
 INSERT INTO Employee
 VALUES(9,'Suman', 'Female', 5000,2500,500,200,4);

 
 INSERT INTO Employee
 VALUES(10,'Tina', 'Female', 6000,3000,500,220,1);


 -- select * from Employee

INSERT INTO Department
VALUES(1,'HR',1);

INSERT INTO Department
VALUES(2,'Admin',2);


INSERT INTO Department
VALUES(3,'Sales',9);


INSERT INTO Department
VALUES(4,'Engineering',5);

-- SELECT * FROM Department

INSERT INTO EmployeeAttendance
VALUES(1,'2010/01/01',22,21);


INSERT INTO EmployeeAttendance
VALUES(1,'2010/02/01',20,20);


INSERT INTO EmployeeAttendance
VALUES(1,'2010/03/01',22,20)


INSERT INTO EmployeeAttendance
VALUES(2,'2010/01/01',22,22)


INSERT INTO EmployeeAttendance
VALUES(2,'2010/02/01',20,20)

INSERT INTO EmployeeAttendance
VALUES(2,'2010/02/01',22,22)

INSERT INTO EmployeeAttendance
VALUES(1,'2010/03/01',22,22)

INSERT INTO EmployeeAttendance
VALUES(3,'2010/01/01',22,21)


INSERT INTO EmployeeAttendance
VALUES(3,'2010/02/01',20,20)

INSERT INTO EmployeeAttendance
VALUES(3,'2010/03/01',22,21)

INSERT INTO EmployeeAttendance
VALUES(4,'2010/01/01',22,21)


INSERT INTO EmployeeAttendance
VALUES(4,'2010/02/01',20,19)


INSERT INTO EmployeeAttendance
VALUES(4,'2010/03/01',22,22)

INSERT INTO EmployeeAttendance
VALUES(5,'2010/01/01',22,22)


INSERT INTO EmployeeAttendance
VALUES(5,'2010/02/01',20,20)


INSERT INTO EmployeeAttendance
VALUES(5,'2010/03/01',22,22)

INSERT INTO EmployeeAttendance
VALUES(6,'2010/01/01',22,21)



INSERT INTO EmployeeAttendance
VALUES(6,'2010/02/01',20,20)

INSERT INTO EmployeeAttendance
VALUES(6,'2010/03/01',22,20)


INSERT INTO EmployeeAttendance
VALUES(7,'2010/01/01',22,21)

INSERT INTO EmployeeAttendance
VALUES(7,'2010/02/01',20,20)

INSERT INTO EmployeeAttendance
VALUES(7,'2010/03/01',22,21)


INSERT INTO EmployeeAttendance
VALUES(8,'2010/01/01',22,21)

INSERT INTO EmployeeAttendance
VALUES(8,'2010/02/01',20,20)

INSERT INTO EmployeeAttendance
VALUES(8,'2010/03/01',22,21)


INSERT INTO EmployeeAttendance
VALUES(9,'2010/01/01',22,22)

INSERT INTO EmployeeAttendance
VALUES(9,'2010/02/01',20,20)

INSERT INTO EmployeeAttendance
VALUES(9,'2010/03/01',22,21)


INSERT INTO EmployeeAttendance
VALUES(10,'2010/01/01',22,22)

INSERT INTO EmployeeAttendance
VALUES(10,'2010/02/01',20,20)

INSERT INTO EmployeeAttendance
VALUES(10,'2010/03/01',22,22)


-- SELECT * FROM eMPLOYEEATTENDANCE



--- queries

1.
	SELECT DeptName,  GENDER, COUNT(*) AS [NO. OF EMPLOYEES] 
	FROM Employee JOIN Department
	ON Employee.DeptID = Department.DeptID
	GROUP BY GENDER, DeptName;
	
2.	
	SELECT DeptName, COUNT(*) AS [NO. OF Employee], MAX( Basic+HR+DA-TAX ) AS [Highest Gross Salary] , SUM(Basic+HR+DA-TAX) AS [Total Salary]
	FROM Employee JOIN Department
	ON Employee.DeptID = Department.DeptID
	GROUP BY DeptName;
3.
	SELECT Name , (
	SELECT 
		MAX(DeptName) AS DeptId,
		MAX( Basic+HR+DA-TAX) AS [Highest Gross Salary]
	FROM 
		Employee 
			JOIN 
		Department
	ON 
		Employee.ID = Department.DeptID
	GROUP BY 
		Department.DeptID) 
		AS T FROM Employee
	WHERE T.ID= Employee.ID
	

4.
	SELECT Id, Name
	FROM	Employee 
	WHERE (Basic+HR+DA-TAX) > 15000;

5.

SELECT Id, NAME FROM EMPLOYEE WHERE BASIC = (
SELECT MAX(BASIC) FROM (
SELECT DISTINCT BASIC FROM Employee) AS T
WHERE BASIC < (SELECT MAX(BASIC) FROM EMPLOYEE)) ;

6.
  
  SELECT * FROM 
  (
  SELECT  DeptName AS DeptName,COUNT(DeptName) AS COUNTS FROM Employee JOIN Department 
  ON Employee.DeptID = Department.DeptID
  GROUP BY DeptName
  ) AS T
  WHERE T.COUNTS >=3;

7.
  
 
  SELECT DeptName, Name
  FROM
	 Department JOIN Employee
  ON
	Department.DeptHeadID = Employee.Id; 

8.
	
	select 
	Name from (
			select 
					max(name) as Name,
					cast(
						case
							when  SUM(WorkingDays) - SUM(PresentDays) = 0
						then	 1
							else
								0
						end
						as int
						) as value
	from
	 Employee join EmployeeAttendance
			on	Employee.Id= EmployeeAttendance.EmpID
	GROUP BY Employee.Id) as t where t.value = 1


9.
	
	SELECT * FROM
	(SELECT MAX(Name) AS Name, SUM(PresentDays) AS Attendance, ROW_NUMBER() OVER( ORDER BY EmpID ASC) AS X
	FROM  EmployeeAttendance JOIN Employee
	ON	EmployeeAttendance.EmpID = Employee.Id
	GROUP BY EmpID
	) AS T
	WHERE T.X=1
	ORDER BY Attendance

10. 
    SELECT * FROM (
		  SELECT MAX(Name) AS Name , 
				 CAST( SUM(WorkingDays)-SUM(PresentDays) AS INT) AS Leaves
		  FROM  
				Employee JOIN EmployeeAttendance
		  ON	
				Employee.Id = EmployeeAttendance.EmpID
		  GROUP BY EmpID )
	AS T
	WHERE T.Leaves >=3
	
	





	
	