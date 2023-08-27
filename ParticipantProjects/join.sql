--Date: 27/08/23
--Author: Esther Afolayan
--Database Engine: Mssql

--create participant table a table using mssql
CREATE TABLE Participants 
(
Staff_id INT, 
First_name Varchar (30), 
Last_name Varchar (30),
Gender Varchar (10), 
Location Varchar (10), 
Age INT
)
--insert values to the created table
INSERT INTO Participants (staff_id, first_name, last_name, gender, location, age)
VALUES (1, 'Eric', 'Akinyelure', 'Male', 'Lagos', 27),
(2, 'Frank', 'Odewunmi', 'Male', 'Lagos', 29),
(3, 'Modupe', 'Famuwagun', 'Female', 'Ontario', 43),
(4, 'Fisayo', 'Akinwale', 'Male', 'Abuja', 27),
(5, 'Iwalewa', 'Poppola', 'Female', 'Abuja', 28),
(6, 'Esther', 'Afolayan', 'Female', 'Lagos', 26),
(7, 'Rofiat', 'Ahmed', 'Female', 'Lagos', 26),
(8, 'Ade', 'Akin', 'Male', 'Abeokuta', 30),
(9, 'Sayo', 'Joseph', 'Female', 'Lagos', 24),
(10, 'Obinna', 'Okoke', 'Male', 'Osogbo', 22);

--create participants_details table
CREATE TABLE Participants_details 
(
Staff_id INT, 
Full_name Varchar (50), 
Grade_level INT, 
Years_of_exp INT, 
Highest_qual Varchar (20), 
Salary INT
)
--insert values to the created table  
INSERT INTO Participants_details
(staff_id, full_name, grade_level, years_of_exp, highest_qual, salary)
VALUES (1,'Eric Akinyelure', 1, 20,'M.Sc.', 270000),
(2, 'Frank Odewunmi', 1, 10, 'M.Sc.', 290000),
(3, 'Modupe Famuwagun', 3, 25, 'M.Sc.', 250000),
(4, 'Fisayo Akinwale', 1, 20, 'B.Sc.', 100000),
(5, 'Iwalewa Poppola', 1, 20, 'B.Sc.', 88000),
(6, 'Esther Afolayan', 1, 20, 'M.Sc.', 260000),
(7, 'Rofiat Ahmed', 1, 20, 'M.Sc.', 200000),
(8, 'Ade Akin', 5, 20, 'M.Sc.', 300000),
(9, 'Sayo Joseph', 6, 20, 'M.Sc.', 240000),
(10, 'Obinna Okoke', 7, 20, 'B.Sc.', 23000);




--Using the Concatenate function,  full name was created from the Participants table

SELECT  Staff_id, 
CONCAT(first_name, ' ',last_name) [Full Name], location, Age 
FROM Participants

--Showing staff_id, full name that was generated in  above and Age of participant(s) whose gender is ‘Male’, Location is ‘Lagos’ and Last name starts with ‘A’

SELECT
  staff_id, 
CONCAT (first_name, ' ', last_name) AS Full_name, age 
FROM participants 
WHERE gender = 'Male' 
  AND location = 'Lagos' 
  AND Last_name LIKE 'A%'

--Using the CASE WHEN statement,an additional field called Salary_category with the following distinctions was created:
•	Less_than_ or_equal_to_100000 named Lowest Earner
•	Less_than_250000 named Moderate Earner
•	Others named Highest Earner

 SELECT 
  staff_id,
  full_name,
	Highest_qual,
  salary,
CASE
  WHEN salary <= 100000 THEN 'Lowest_Earner'
  WHEN salary < 250000 THEN 'Moderate_Earner'
	ELSE 'Highest_Earner'
  END AS Salary_Category
  FROM Participants_details


--Using subquery,  participant’s full name, Salary and highest_qual from the Participants_details table whose salary is greater than the average salary was derived.
SELECT Full_name, Highest_qual, Salary
FROM Participants_details
WHERE Salary > (SELECT AVG(Salary) FROM Participants_details)

--LEFT JOIN was used to create a new table called Participants_Master whose fields were made up of  Staff_id, First_name, Last_name, Age, Highest_qual and Salary for each participant.

SELECT * INTO Participant_Master
from
(
SELECT p.Staff_id, First_name, Last_name, Age, Highest_qual, Salary
FROM Participants p
LEFT JOIN Participants_details pd
ON p.Staff_id = pd.Staff_id
) aselect *,
Case 
	when salary <=100000 Then 'Lowest Earner'
	when salary <250000 Then 'Moderate Earner'
	Else  'Highest Earner'
End As Salary_Category
From  Participants_details
