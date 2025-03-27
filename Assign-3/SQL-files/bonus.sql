# triggers for updating a student's GPA when a grade is updated.
DELIMITER //
CREATE TRIGGER update_gpa
AFTER UPDATE ON enrollments  
FOR EACH ROW  
BEGIN  
    DECLARE total_points DECIMAL(10,2);  
    DECLARE total_courses INT;  

    # calculate new total grade points
    SELECT SUM(grade) INTO total_points  
    FROM enrollments  
    WHERE student_id = NEW.student_id;  

    # count total courses taken
    SELECT COUNT(*) INTO total_courses  
    FROM enrollments  
    WHERE student_id = NEW.student_id;  

    # prevent division by zero
    IF total_courses = 0 THEN  
        UPDATE students SET GPA = 0 WHERE student_id = NEW.student_id;  
    ELSE  
        UPDATE students  
        SET GPA = (total_points / total_courses)  
        WHERE student_id = NEW.student_id;  
    END IF;  
END //
DELIMITER ;


# store procedure for enrolling a student in a course.
DELIMITER //
CREATE PROCEDURE  enroll_student(
    IN student_id_param INT,
    IN course_id_param INT
)
BEGIN
    DECLARE student_exists INT DEFAULT 0;
    DECLARE course_exists INT DEFAULT 0;
    DECLARE already_enrolled INT DEFAULT 0;

    # check if the student exists
    SELECT COUNT(*) INTO student_exists FROM students WHERE student_id = student_id_param;

    IF student_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student not found';
    END IF;

    # check if the course exists
    SELECT COUNT(*) INTO course_exists FROM courses WHERE course_id = course_id_param;

    IF course_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Course not found';
    END IF;

    # check if the student is already enrolled in the course
    SELECT COUNT(*) INTO already_enrolled FROM enrollments 
    WHERE student_id = student_id_param AND course_id = course_id_param;

    IF already_enrolled > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student is enrolled in this course already!!';
    END IF;

    # enroll the student in the course
    INSERT INTO enrollments (student_id, course_id, enrollment_date)
    VALUES (student_id_param, course_id_param, CURDATE());

    # return success message
    SELECT 'Student enrolled in the course successfully!' AS message;
END //
DELIMITER ;

# execute the store procedure 
CALL enroll_student(1, 5); 