-- Q1.
SELECT dept_id, COUNT(*) AS Num_Students
FROM STUDENT
GROUP BY dept_id;

-- Q2.
SELECT dept_id, AVG(gpa) AS avg_gpa
FROM STUDENT
GROUP BY dept_id
HAVING AVG(gpa) > 3;

-- Q3.
SELECT course_id, AVG(fee) AS avg_fee
FROM STUDENT
GROUP BY course_id; 

-- Q4.
SELECT dept_id, COUNT(*) AS num_faculty
FROM FACULTY
GROUP BY dept_id;

-- Q5.
SELECT *
FROM FACULTY
WHERE salary > (SELECT AVG(salary) FROM FACULTY);

-- Q6.
SELECT *
FROM STUDENT
WHERE gpa > ANY (
    SELECT gpa FROM STUDENT WHERE dept_id  = (SELECT dept_id FROM DEPARTMENT WHERE dept_name = "CS")
);

-- Q7.
SELECT * 
FROM STUDENT
ORDER BY gpa DESC
FETCH FIRST 3 ROWS ONLY;

-- Q8.
SELECT s1.student_id, s1.name
FROM STUDENT s1
WHERE NOT EXISTS (
    SELECT course_id FROM ENROLL WHERE student_id = (
        SELECT student_id FROM STUDENT WHERE name = 'Ali'
    )
    AND course_id NOT IN(
        SELECT course_id FROM ENROLL WHERE student_id = s1.student_id
    )
);

-- Q9.
SELECT s.dept_id, SUM(s.fee) AS total_fee
FROM STUDENT s
GROUP BY s.dept_id;

-- Q10.
SELECT DISTINCT course_id
FROM ENROLL
WHERE student_id in (
    SELECT student_id FROM STUDENT WHERE gpa > 3.5
);
