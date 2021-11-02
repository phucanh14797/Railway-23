DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE testing_system;
USE testing_system;

ALTER DATABASE testing_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Department
CREATE TABLE department( 
	department_id  	TINYINT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) CHAR SET utf8mb4 NOT NULL
);
-- Add data Department
INSERT INTO department(department_name)
VALUES		('Marketing'),
			('Sale'),
            ('Bảo vệ'),
            ('Nhân sự'),
            ('Kỹ thuật'),
            ('Tài chính'),
            ('Phó giám đốc'),
            ('Giám đốc'),
            ('Thư ký'),
            ('Bán hàng');
            
-- Poisition
CREATE TABLE `position`(
	position_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
    position_name	ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);
-- Add data Position
INSERT INTO `position`(position_name)
VALUES		('Dev' ),
			('Test'),
            ('Scrum Master'),
            ('PM');

-- Account
CREATE TABLE `account`(
	account_id		INT AUTO_INCREMENT PRIMARY KEY,
    email			VARCHAR(50) UNIQUE NOT NULL,
    username		VARCHAR(30) UNIQUE NOT NULL,
    fullname		VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    department_id	TINYINT NOT NULL,
    position_id		TINYINT NOT NULL,
    create_date		DATE,
    FOREIGN KEY(department_id) REFERENCES department(department_id),
    FOREIGN KEY(position_id) REFERENCES `position`(position_id)
);
-- Add data Account
INSERT INTO `account`(email, username, fullname, department_id, position_id, create_date)
VALUES      ('a@gmail.com', 'a1', 'NGUYỄN VĂN A', 5, 1, '20211017'),
			('b@gmail.com', 'b1', 'NGUYỄN VĂN B', 5, 2, '20211017'),
			('c@gmail.com', 'c1', 'NGUYỄN VĂN C', 5, 3, '20211017'),
            ('d@gmail.com', 'd1', 'NGUYỄN VĂN D', 5, 4, '20211017'),
            ('e@gmail.com', 'e1', 'NGUYỄN VĂN E', 5, 1, '20211017');

-- Group
CREATE TABLE `group`(
	group_id 	INT AUTO_INCREMENT PRIMARY KEY,
    group_name	VARCHAR(50),
    creator_id	INT,
    create_date	DATE,
    FOREIGN KEY(creator_id) REFERENCES `account`(account_id)
);
-- Add data Group
INSERT INTO `group`(group_name, creator_id, create_date)
VALUES		('SQL',1,20211017),
			('JAVA',1,20211017),
			('HTML/CSS',1,20211017),
            ('C++',1,20211017),
            ('C#',1,20211017);
            
-- GroupAccount
CREATE TABLE group_account(
	group_id	INT,
	account_id	INT,	
	join_date 	DATE,
    FOREIGN KEY(group_id) REFERENCES `group`(group_id),
    FOREIGN KEY(account_id) REFERENCES `account`(account_id)
);
-- Add data Group_account
INSERT INTO `group_account`(group_id, account_id, join_date)
VALUES		(1,1,20211017),
			(2,5,20211017),
			(3,3,20211017),
            (4,4,20211017),
            (5,2,20211017);	

-- Type Question
CREATE TABLE type_question(
	type_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
	type_name	ENUM('Essay','Multiple-Choise')
);
-- Add data Type_Question
INSERT INTO type_question(type_name)
VALUES		('Multiple-Choise'),
			('Essay');

-- Category_Question
CREATE TABLE category_question(
	category_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
	category_name	VARCHAR(30) CHAR SET utf8mb4
);
-- Add data Category_Question
INSERT INTO category_question(category_name)
VALUES		('TOÁN SỐ HỌC'),
			('TOÁN HÌNH HỌC'),
			('VẬT LÝ'),
            ('HÓA HỌC'),
            ('TIN HỌC');	

-- Question
CREATE TABLE question(
	question_id		INT AUTO_INCREMENT PRIMARY KEY,
	content			VARCHAR(1000) CHAR SET utf8mb4,
    category_id		INT,
    type_id			INT,
	creator_id		INT,
    create_date		DATE,
    FOREIGN KEY(creator_id) REFERENCES `account`(account_id)
);
-- Add data Category_Question
INSERT INTO question(content, category_id, type_id, creator_id, create_date)
VALUES		('1 + 1 = ?',1,1,1,20211017),
			('Hình tam giác có mấy cạnh ?',2,1,1,20211017),
            ('Nước sôi ở bao nhiêu độ ?',3,1,1,20211017),
            ('Ký hiệu hóa học của sắt là gì ?',4,1,1,20211017),
            ('Bộ phận nào được ví như bộ não của máy tính ?',5,1,1,20211017);

-- Answer
CREATE TABLE answer(
	answer_id		INT AUTO_INCREMENT PRIMARY KEY,
	content			VARCHAR(1000),
    question_id		INT,
    is_correct		BOOLEAN,
    FOREIGN KEY(question_id) REFERENCES question(question_id)
);
-- Add Answer
INSERT INTO answer(content, question_id, is_correct)
VALUES		('2',1,1),
			('3',2,1),
            ('100 độ C',3,1),
            ('Fe',4,1),
            ('CPU',1,1);

-- Exam
CREATE TABLE exam(
	exam_id			SMALLINT AUTO_INCREMENT PRIMARY KEY,
	`code`			INT,
	title			VARCHAR(100) CHAR SET utf8mb4,
    category_id		TINYINT,
    duration		INT,
    creator_id		INT,
    create_date		DATE,
    FOREIGN KEY(creator_id) REFERENCES `account`(account_id),
    FOREIGN KEY(category_id) REFERENCES category_question(category_id)
);
-- Add Exam
INSERT INTO exam(`code`, title, category_id, duration, creator_id, create_date)
VALUES  	(1111, 'TEST TRÌNH ĐỘ TOÁN SỐ HỌC', 1, 60, 1, 20211017),
			(2222, 'TEST TRÌNH ĐỘ TOÁN HÌNH HỌC', 2, 60, 1, 20211017),
            (3333, 'TEST TRÌNH ĐỘ VẬT LÝ', 3, 60, 1, 20211017),
            (4444, 'TEST TRÌNH ĐỘ HÓA HỌC', 4, 60, 1, 20211017),
            (5555, 'TEST TRÌNH ĐỘ TIN HỌC', 5, 60, 1, 20211017);

-- ExamQuestion
CREATE TABLE exam_question(
	exam_id			SMALLINT,
	question_id		INT,
    FOREIGN KEY(exam_id) REFERENCES exam(exam_id),
    FOREIGN KEY(question_id) REFERENCES question(question_id)
);
-- Add Exam Question
INSERT INTO exam_question(exam_id, question_id)
VALUES		(1,1),
			(2,2),
            (3,3),
            (4,4),
            (5,5);
