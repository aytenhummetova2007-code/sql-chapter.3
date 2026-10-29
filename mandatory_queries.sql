-- Exercise 3.11(a)
SELECT DISTINCT student.ID, student.name
FROM student, takes, course
WHERE student.ID = takes.ID 
  AND takes.course_id = course.course_id
  AND course.dept_name = 'Comp. Sci.';
-- Exercise 3.11(b)
SELECT ID, name
FROM student
WHERE ID NOT IN (
    SELECT ID FROM takes WHERE year < 2017
);
-- Exercise 3.11(c)
SELECT dept_name, MAX(salary) AS max_salary
FROM instructor
GROUP BY dept_name;
-- Exercise 3.11(d)
SELECT MIN(max_salary) 
FROM (
    SELECT MAX(salary) AS max_salary 
    FROM instructor 
    GROUP BY dept_name
);
-- Exercise 3.15(a)
SELECT customer_name
FROM depositor, account, branch
WHERE depositor.account_number = account.account_number
  AND account.branch_name = branch.branch_name
  AND branch.branch_city = 'Brooklyn'
GROUP BY customer_name
HAVING COUNT(DISTINCT branch.branch_name) = (
    SELECT COUNT(*) FROM branch WHERE branch_city = 'Brooklyn'
);

-- Exercise 3.15(b)
SELECT SUM(amount) FROM loan;

-- Exercise 3.15(c)
SELECT branch_name
FROM branch
WHERE assets > SOME (
    SELECT assets FROM branch WHERE branch_city = 'Brooklyn'
);

-- Exercise 3.24
SELECT student.ID, student.name
FROM student, advisor, instructor
WHERE student.ID = advisor.s_ID 
  AND advisor.i_ID = instructor.ID
  AND student.dept_name = 'Accounting' 
  AND instructor.dept_name = 'Physics';

-- Exercise 3.25
SELECT dept_name
FROM department
WHERE budget > (SELECT budget FROM department WHERE dept_name = 'Philosophy')
ORDER BY dept_name ASC;
