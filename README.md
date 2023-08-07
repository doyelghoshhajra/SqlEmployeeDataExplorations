![image](https://github.com/doyelghoshhajra/SqlEmployeeDataExplorations/assets/140665913/74a181c7-52fd-4c46-92f4-f82791ea8cfe)

-- In this query:
-- The RankedEmployees common table expression (CTE) is created by joining the employees and departments tables using the department_id field.
-- This allows you to include the department_name in the result set.
-- The DENSE_RANK() window function is used within the CTE
-- 						to assign a dense rank to each employee within their respective department, ordered by their hire date.
-- The main query selects the employee details from the RankedEmployees CTE where the experience_dense_rank is equal to 3,
-- 						which corresponds to the third highest experienced employee in each department.
-- This query provides you with the third highest experienced employee per department_name
-- 						using the DENSE_RANK() function, a CTE, and appropriate joins between the two tables.

Query Plan:

![image](https://github.com/doyelghoshhajra/SqlEmployeeDataExplorations/assets/140665913/ca1aac86-ff2b-40ad-ad71-a0cb926a0900)






![image](https://github.com/doyelghoshhajra/SqlEmployeeDataExplorations/assets/140665913/850cea8e-350a-4a77-9383-916df6401b33)

Query Plan:

![image](https://github.com/doyelghoshhajra/SqlEmployeeDataExplorations/assets/140665913/b9bc2953-486a-46a4-a00b-253e8ac054c6)


