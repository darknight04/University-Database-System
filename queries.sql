
/* 1. Name of instructors from Biology dept.*/
SELECT name FROM instructor 
WHERE  
dept_name = "Biology"; 

/* 2. Names of courses in Computer Science department which have 3 credits */
SELECT title FROM course 
WHERE dept_name = "Comp. Sci." AND credits = 3; 

/* 3. For the student with ID 17424 , displaying all course_id and title of all courses registered for by the studen*/ 
SELECT course.course_id, title 
FROM course, takes 
WHERE course.course_id = takes.course_id 
AND takes.ID = 17424;


/* 4. For the student with ID 17424, displaying the total number of credits taken by that student. Use SQL aggregation on courses taken by the student. */
SELECT SUM(course.credits)  
FROM course, takes  
WHERE course.course_id = takes.course_id  
AND takes.ID = 17424; 

/* 5. Displaying the total credits for each student, along with the ID of the student */
SELECT takes.ID, SUM(course.credits)
FROM course, takes
WHERE course.c
course_id = takes.course_id
GROUP BY takes.ID

/* 6. Finding the names of all students who have taken any Comp. Sci. course ever */
SELECT DISTINCT S.name  
FROM takes T, course C, student S 
WHERE C.dept_name = 'Comp. Sci.' and T.course_id = C.course_id and T.ID = S.ID


/* 7. Displayig the IDs of all instructors who have never taught a couse.*/
select id from instructor except 
(select teaches.id from teaches, instructor where teaches.id = instructor.id) 

/*
Intermediate SQL queries  

*/

/* 1. Finding the maximum and minimum enrollment across all sections, considering only sections that had some enrollment. */
SELECT min(enrollment) as min_enrol, max(enrollment) as maxEnrol  FROM (SELECT count(*) as enrollment 
FROM takes 
group by course_id, sec_id, semester, year) as countBySection 
We id not cover aggregate queries in RA, Tuple Calculus, and Domain Calculus. That being said,  MAX and MIN can be computed with the standard calculus. 

/* 2. Finding all sections that had the maximum enrollment (along with the enrollment), using a subquery. */
SELECT course_id, sec_id, semester, year, count(*) AS MaxEnrollment 
FROM takes 
GROUP BY course_id, sec_id, semester, year
HAVING count(*) = (SELECT MAX(count) 
FROM (SELECT COUNT(ID) AS count 
FROM  
takes 
GROUP BY course_id, sec_id, semester, year)  
AS studentCount) 

/* 3. Find all courses whose identifier starts with the string "CS-1". */
SELECT * FROM course 
WHERE course_id LIKE "CS-1%"; 

/*
Advanced SQL queries  
*/

/* 1. Creating a view faculty showing only the ID, name, and department of instructors.*/
CREATE VIEW faculty AS (SELECT ID, name, dept_name FROM instructor); 

/*2. Creating a view CSinstructors, showing all information about instructors from the Comp. Sci. department. */
CREATE VIEW CSinstructors AS (SELECT * 
FROM instructor 
WHERE dept_name = "Comp. Sci."); 

/* 3. Finding all rooms that have been assigned to more than one section at the same time. Display the rooms along with the assigned sections */
SELECT s1.building, s1.room_number, s1.semester, s1.year, s1.time_slot_id, s1.course_id, s1.sec_id
FROM section s1
WHERE EXISTS (
    SELECT 1
    FROM section s2
    WHERE s1.building = s2.building
      AND s1.room_number = s2.room_number
      AND s1.semester = s2.semester
      AND s1.year = s2.year
      AND s1.time_slot_id = s2.time_slot_id
      AND (s1.course_id <> s2.course_id OR s1.sec_id <> s2.sec_id)
);

/* 4. A stored procedure that retrieves the names of instructors in a specific department. */
DELIMITER //
CREATE PROCEDURE GetInstructorsByDepartment(IN dept_name_param VARCHAR(20))
BEGIN
    SELECT name
    FROM instructor
    WHERE dept_name = dept_name_param;
END //
DELIMITER ;

/* 5. Stored procedure to calculate the average salary by department */
DELIMITER //
CREATE PROCEDURE CalculateAverageSalary(IN dept_name_param VARCHAR(20), OUT avg_salary DECIMAL(10, 2))
BEGIN
    SELECT AVG(salary) INTO avg_salary
    FROM instructor
    WHERE dept_name = dept_name_param;
END //
DELIMITER ;

-- Calling thhe stored procedure
CALL CalculateAverageSalary('Comp. Sci.', @average_salary);
SELECT @average_salary;