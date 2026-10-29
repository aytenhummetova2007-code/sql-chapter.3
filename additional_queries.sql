
-- Exercise 3.26
SELECT course_id, ID
FROM takes
GROUP BY course_id, ID
HAVING COUNT(*) >= 3
ORDER BY course_id;
-- Exercise 3.27
SELECT ID
FROM (
    SELECT ID, course_id
    FROM takes
    GROUP BY ID, course_id
    HAVING COUNT(*) >= 2
)
GROUP BY ID
HAVING COUNT(DISTINCT course_id) >= 3;
-- Exercise 3.28
SELECT instructor.ID, instructor.name
FROM instructor, teaches, course
WHERE instructor.ID = teaches.ID 
  AND teaches.course_id = course.course_id
  AND instructor.dept_name = course.dept_name
GROUP BY instructor.ID, instructor.name, instructor.dept_name
HAVING COUNT(DISTINCT teaches.course_id) = (
    SELECT COUNT(*) FROM course WHERE dept_name = instructor.dept_name
)
ORDER BY instructor.name;
-- Exercise 3.31
SELECT ID, name
FROM instructor
WHERE ID NOT IN (
    SELECT teaches.ID 
    FROM teaches, takes 
    WHERE teaches.course_id = takes.course_id
      AND teaches.sec_id = takes.sec_id
      AND teaches.semester = takes.semester
      AND teaches.year = takes.year
      AND takes.grade = 'A'
);
-- Exercise 3.34
SELECT course_id, sec_id, year, semester, COUNT(ID) AS num
FROM takes
GROUP BY course_id, sec_id, year, semester;
-- Exercise 3.35
SELECT course_id, sec_id, year, semester, COUNT(ID) AS num
FROM takes
GROUP BY course_id, sec_id, year, semester
HAVING COUNT(ID) >= ALL (
    SELECT COUNT(ID)
    FROM takes
    GROUP BY course_id, sec_id, year, semester
);
