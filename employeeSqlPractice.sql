#1 Select top 10 employees with  highest salary in descending order
Select * from interview.employees order by salary desc limit 10;

#2-1 Select employees from department: Marketing (One way)
select employees.* from interview.employees
left join interview.departments
on employees.department_id = departments.department_id
where departments.department_name="Marketing";

#2-2 Select employees from department: Marketing (Alternative way)
select employees.* from employees, departments
where employees.department_id = departments.department_id
and departments.department_name = "Marketing";

#2-a Adding one record of null department_id to employees and running #2-1&#2-2 to check if it reads the null value
INSERT INTO employees
VALUES (
	405,
	'abacus',
    'paribus',
    'abc',
    '232',
    STR_TO_DATE('17-JUN-1987', '%d-%M-%Y'),
    'AD_PRES',
    123456,
    null,
    201,
    null
	);
#Insight: It still did not read

#2-b Omitting the where clause
select employees.employee_id, departments.department_name from interview.employees
left join interview.departments
on employees.department_id = departments.department_id;
#Insight: It read this time.
#Hence the conclusion is: Even if left join is done, if there is a 'where' clause after left join, it applies to both the tables before selecting.

#3 Select highest paid employee in IT
select employees.* from employees, departments
where employees.department_id = departments.department_id
and departments.department_name = "IT"
order by employees.salary Desc
limit 1;

#4 Get top paid employee for each dept
select employees.first_name,dept_max_sal.department_name,employees.salary
from interview.employees,
(SELECT max(salary) as max_salary,departments.department_name
     FROM interview.employees,interview.departments
     where interview.employees.department_id = interview.departments.department_id
     GROUP BY departments.department_name) as dept_max_sal
where employees.salary = dept_max_sal.max_salary
order by dept_max_sal.department_name;

#5 Select employees who have no manager
select employees.* from interview.employees where manager_id is null;

#6 Select employees and manager name (self join)
select e.first_name as e_name, m.first_name as m_name, e.employee_id, m.employee_id as mngr
from interview.employees as e, interview.employees as m
where e.manager_id = m.employee_id;

#7 Find highest experience employee per department
SELECT max(datediff(CURDATE(), employees.hire_date)) AS max_exp, employees.first_name, employees.hire_date, departments.department_name
     FROM interview.employees, interview.departments
     where employees.department_id = departments.department_id
     GROUP BY departments.department_name;

#8 Find third highest experienced employee per department
WITH RankedEmployees AS (
    SELECT e.employee_id, e.first_name, e.last_name, e.hire_date, d.department_name,
	DENSE_RANK() OVER (PARTITION BY d.department_name ORDER BY e.hire_date) AS experience_dense_rank
    FROM interview.employees e
    JOIN interview.departments d
    ON e.department_id = d.department_id
)
SELECT re.employee_id, re.first_name, re.last_name, re.hire_date, re.department_name
FROM RankedEmployees re
WHERE re.experience_dense_rank = 3;

-- In this query:
-- The RankedEmployees common table expression (CTE) is created by joining the employees and departments tables using the department_id field.
-- This allows you to include the department_name in the result set.
-- The DENSE_RANK() window function is used within the CTE
-- 						to assign a dense rank to each employee within their respective department, ordered by their hire date.
-- The main query selects the employee details from the RankedEmployees CTE where the experience_dense_rank is equal to 3,
-- 						which corresponds to the third highest experienced employee in each department.
-- This query provides you with the third highest experienced employee per department_name
-- 						using the DENSE_RANK() function, a CTE, and appropriate joins between the two tables.
-------------------------------------------------------

#9 Select the job with maximum salary
select employees.salary, departments.department_name
from interview.employees, interview.departments
where employees.department_id = departments.department_id
order by employees.salary desc limit 1;








