#  1. Retrieve all students enrolled in a specific course
SELECT students.student_id, students.student_first_name, students.student_last_name, students.student_email  
FROM students  
JOIN enrollments ON students.student_id = enrollments.student_id  
WHERE enrollments.course_id = 3;

#  2. Find all faculty members in a particular department
SELECT faculty_id, faculty_first_name, faculty_last_name 
FROM faculty 
WHERE department_id = 2;

#  3. List all courses a student is enrolled in
SELECT courses.course_code,  courses.course_name 
FROM courses
JOIN enrollments ON  courses.course_id = enrollments.course_id
WHERE enrollments.student_id = 1;

# 4. Retrieve students who have not enrolled in any course
SELECT * FROM students 
WHERE student_id NOT IN (SELECT student_id FROM enrollments);

# 5. Find the average grade of students in a specific course
SELECT AVG(grade) AS average_grade 
FROM enrollments 
WHERE course_id = 3;

