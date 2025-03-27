#  1. Retrieve all students enrolled in a specific course
SELECT students.student_id, students.student_first_name, students.student_last_name, students.student_email  
FROM students  
JOIN enrollments ON students.student_id = enrollments.student_id # use join for 'students' table with 'enrollments' to get student details for the course. 
WHERE enrollments.course_id = 3;

#  2. Find all faculty members in a particular department
SELECT faculty_id, faculty_first_name, faculty_last_name 
FROM faculty 
WHERE department_id = 2; # search for faculty members based on the department ID.

#  3. List all courses a student is enrolled in
SELECT courses.course_code,  courses.course_name 
FROM courses
JOIN enrollments ON  courses.course_id = enrollments.course_id # use join 'courses' and 'enrollments' to list courses that student is taking.
WHERE enrollments.student_id = 1;

# 4. Retrieve students who have not enrolled in any course
SELECT * FROM students 
WHERE student_id NOT IN (SELECT student_id FROM enrollments);  # selects students that are not present in the 'enrollments' table by using sub-query.

# 5. Find the average grade of students in a specific course
SELECT AVG(grade) AS average_grade 
FROM enrollments # calculate the average grade using aggregate function AVG of all students in one course.
WHERE course_id = 3;

