CREATE DATABASE employee;
USE employee;

ALTER DATABASE employee CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS department_employee;
CREATE TABLE department(
	department_Number	TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    department_Name		VARCHAR(40) UNIQUE KEY NOT NULL
);
INSERT INTO department(Department_Name)
VALUES		(N'Nhân sự'),
			(N'Hành chính'),
            (N'Marketing'),
            (N'Sale'),
            (N'Lễ tân'),
            (N'Chăm sóc kh'),
            (N'Bảo vệ'),
            (N'PTTT'),
            (N'Giám đốc'),
            (N'HĐQT');
            		
DROP TABLE IF EXISTS Employee_Table;
CREATE TABLE employee_table(
	employee_number		TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    employee_name		VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    department_number	TINYINT,
    FOREIGN KEY (Department_Number) REFERENCES department(Department_Number)
);
INSERT INTO Employee_Table(Employee_Name,Department_Number)
VALUES		(N'NGUYỄN VĂN A',1),
			(N'NGUYỄN VĂN B',2),
            (N'NGUYỄN VĂN C',4),
            (N'NGUYỄN VĂN D',9),
            (N'NGUYỄN VĂN E',5),
            (N'NGUYỄN VĂN F',1),
            (N'NGUYỄN VĂN G',3),
            (N'NGUYỄN VĂN H',7),
            (N'NGUYỄN VĂN I',8),
            (N'NGUYỄN VĂN K',6);
            
DROP TABLE IF EXISTS employee_skill_table;
CREATE TABLE employee_skill_table(
	employee_number		TINYINT NOT NULL,
    skill_code			VARCHAR(10) NOT NULL,
    date_registered		DATE NOT NULL,
    FOREIGN KEY (employee_number) REFERENCES employee_table(employee_number)
);
INSERT INTO employee_skill_table(employee_number,skill_code,date_registered)
VALUES		(1,N'Sql','2015-01-01'),
			(1,N'Sql','2016-01-01'),
            (2,N'Web','2015-02-01'),
            (3,N'Java','2017-01-01'),
            (4,N'Web','2018-01-01'),
            (5,N'Sql','2015-01-01'),
            (5,N'Web','2016-01-01'),
            (5,N'Java','2017-01-01'),
            (7,N'Java','2019-01-01'),
            (8,N'Java','2019-01-01');

-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java Hướng dẫn: sử dụng UNION

SELECT employee_name
FROM employee_table et
JOIN employee_skill_table est ON et.employee_number = est.employee_number
WHERE skill_code = 'Java';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên

SELECT d.department_number,department_name,count(employee_number)
FROM department d
JOIN employee_table et ON d.department_number = et.department_number
GROUP BY d.department_Number
HAVING count(employee_number) > 3;

-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban. Hướng dẫn: sử dụng GROUP BY

SELECT department_name,GROUP_CONCAT(employee_name)
FROM employee_table et
JOIN department d ON et.department_number = d.department_number
GROUP BY et.department_number;

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.

SELECT employee_name,COUNT(skill_code),GROUP_CONCAT(skill_code)
FROM employee_table et
JOIN employee_skill_table est ON et.Employee_Number = est.employee_number
GROUP BY et.employee_number
HAVING COUNT(skill_code) > 1;