#  create the database
create database university_db;

#  create table students
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_first_name VARCHAR(50) NOT NULL,
    student_last_name VARCHAR(50) NOT NULL,
    student_email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE NOT NULL
);

#  departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

# faculty table
CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_first_name VARCHAR(50) NOT NULL,
    faculty_last_name varchar(50) NOT NULL,
    faculty_email varchar(100) not null,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

#  courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id) ON DELETE SET NULL
);

# enrollments table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade DECIMAL(4,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- sample data inserted
INSERT INTO students (student_first_name, student_last_name, student_email, date_of_birth) VALUES
('Ron', 'Weasley','ron@gmail.com', '2001-06-15'),
('Jennie', 'Kim','jennie@gmail.com', '2001-05-10'),
('Jisoo', 'Kim','jisoo@gmail.com', '2002-11-23'),
('Lalisa', 'Manoban','lisa@gmail.com', '2001-09-05'),
('Chaeyoung', 'Park','rose@gmail.com', '2000-12-26'),
('Harry', 'Potter','harry@gmail.com', '2001-10-11'),
('Hermione', 'Granger','hermione@gmail.com', '2000-12-11'),
('Draco', 'Malfoy','draco@gmail.com', '2001-04-20'),
('Jeff', 'Satur','jeff@gmail.com', '2001-04-20'),
('Peter', 'Parker','peter@gmail.com', '2004-10-20');

INSERT INTO departments (department_name) VALUES
('Computer Science'),
('History'),
('Philosophy'),
('Mathematics');

INSERT INTO faculty (faculty_first_name, faculty_last_name, faculty_email, department_id) VALUES
('Dr. Tony', 'Stark','tony@gmail.com', 1),
('Dr. Kris', 'Jenner','kris@gmail.com', 2),
('Dr. Wanda', 'Maximoff','wanda@gmail.com', 3),
('Dr. Kim', 'Kardashian','kim@gmail.com', 4);

INSERT INTO courses (course_code, course_name, faculty_id) VALUES
('CS101', 'Intro to Programming', 1),
('HIST101', 'World History', 2),
('PHIL101', 'Introduction to Philosophy', 3),
('MATH201', 'Calculus I', 4);

INSERT INTO enrollments (student_id, course_id, enrollment_date, grade) VALUES
(1, 1, '2025-01-10', 85.5),
(2, 4, '2025-01-12', 90.0),
(3, 1, '2025-02-01', 78.0),
(4, 2, '2025-02-05', 82.5),
(5, 3, '2025-02-08', 88.0),
(6, 4, '2025-02-12', 75.5),
(7, 1, '2025-02-15', 91.0),
(8, 2, '2025-02-18', 79.5),
(9, 3, '2025-02-20', 87.0),
(10, 4, '2025-02-25', 83.5);


