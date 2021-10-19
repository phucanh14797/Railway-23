DROP DATABASE IF EXISTS Testing_System_Assignment_3;
CREATE DATABASE Testing_System_Assignment_3;
USE Testing_System_Assignment_3;

ALTER DATABASE Testing_System_Assignment_3 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Department
CREATE TABLE department( 
	department_id  	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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
            ('Bán hàng'),
            ('Giám sát'),
            ('Dịch vụ'),
            ('Tài vụ'),
            ('Kế hoạch'),
            ('Pháp lý');
            
-- Poisition
CREATE TABLE `position`(
	position_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    position_name	ENUM('Dev', 'Test', 'Scrum Master', 'PM', 'Giám đốc','Thư ký','Phó giám đốc','Trưởng phòng Marketing','Trưởng phòng Sale','Trưởng phòng Dịch vụ','Trưởng phòng Giám sát','Trưởng phòng Tài vụ','Trưởng phòng Kế hoạch','Trưởng phòng Tài chính','Trưởng phòng Pháp chế') CHAR SET utf8mb4
);
-- Add data Position
INSERT INTO `position`(position_name)
VALUES		('Dev' ),
			('Test'),
            ('Scrum Master'),
            ('PM'),
            ('Giám đốc'),
			('Thư ký'),
            ('Phó giám đốc'),
            ('Trưởng phòng Marketing'),
            ('Trưởng phòng Sale'),
            ('Trưởng phòng Dịch vụ'),
            ('Trưởng phòng Giám sát'),
            ('Trưởng phòng Tài vụ'),
            ('Trưởng phòng Kế hoạch'),
            ('Trưởng phòng Tài chính'),
            ('Trưởng phòng Pháp chế');
            
		
-- Account
CREATE TABLE `account`(
	account_id		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email			VARCHAR(100) UNIQUE NOT NULL,
    username		VARCHAR(100) UNIQUE NOT NULL,
    fullname		VARCHAR(100) CHAR SET utf8mb4 NOT NULL,
    department_id	TINYINT UNSIGNED NOT NULL,
    position_id		TINYINT UNSIGNED NOT NULL,
    create_date		DATE,
    FOREIGN KEY(department_id) REFERENCES department(department_id),
    FOREIGN KEY(position_id) REFERENCES `position`(position_id)
);
-- Add data Account
INSERT INTO `account`(email, username, fullname, department_id, position_id, create_date)
VALUES      ('a@gmail.com', 'a1', 'NGUYỄN VĂN A', 5, 1, "2021-10-17"),
			('b@gmail.com', 'b1', 'NGUYỄN VĂN B', 5, 2, "2021-10-17"),
			('c@gmail.com', 'c1', 'NGUYỄN VĂN C', 5, 3, "2021-10-17"),
            ('d@gmail.com', 'd1', 'NGUYỄN VĂN D', 5, 4, "2021-10-17"),
            ('e@gmail.com', 'e1', 'NGUYỄN VĂN E', 8, 5, "2021-10-17"),
			('f@gmail.com', 'f1', 'NGUYỄN VĂN F', 8, 6, "2021-10-17"),
            ('g@gmail.com', 'g1', 'NGUYỄN VĂN G', 7, 7, "2021-10-17"),
            ('h@gmail.com', 'h1', 'NGUYỄN VĂN H', 1, 8, "2021-10-17"),
            ('i@gmail.com', 'i1', 'NGUYỄN VĂN I', 2, 9, "2021-10-17"),
            ('k@gmail.com', 'k1', 'NGUYỄN VĂN K', 12, 10, "2021-10-17"),
            ('l@gmail.com', 'l1', 'NGUYỄN VĂN L', 11, 11, "2021-10-17"),
            ('m@gmail.com', 'm1', 'NGUYỄN VĂN M', 13, 12, "2021-10-17"),
            ('n@gmail.com', 'n1', 'NGUYỄN VĂN N', 14, 13, "2021-10-17"),
            ('o@gmail.com', 'o1', 'NGUYỄN VĂN O', 6, 14, "2021-10-17"),
            ('p@gmail.com', 'p1', 'NGUYỄN VĂN P', 15, 15, "2021-10-17");
-- Group
CREATE TABLE `group`(
	group_id 	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    group_name	VARCHAR(100) CHAR SET utf8mb4,
    creator_id	INT UNSIGNED,
    create_date	DATE,
    FOREIGN KEY(creator_id) REFERENCES `account`(account_id)
);
-- Add data Group
INSERT INTO `group`(group_name, creator_id, create_date)
VALUES		('SQL',1,"2021-10-17"),
			('JAVA',1,"2021-10-17"),
			('HTML/CSS',1,"2021-10-17"),
            ('C++',1,"2021-10-17"),
            ('C#',1,"2021-10-17"),
            ('Hội đồng quản trị',1,"2021-10-17"),
            ('Dự án 1',1,"2021-10-17"),
			('Dự án 2',1,"2021-10-17"),
			('Dự án 3',1,"2021-10-17"),
			('Dự án 4',1,"2021-10-17"),
			('Dự án 5',1,"2021-10-17"),
			('Dự án 6',1,"2021-10-17"),
			('Dự án 7',1,"2021-10-17"),
			('Dự án 8',1,"2021-10-17"),
			('Dự án 9',1,"2021-10-17");
            
-- GroupAccount
CREATE TABLE group_account(
	group_id	INT UNSIGNED,
	account_id	INT UNSIGNED,	
	join_date 	DATE,
    FOREIGN KEY(group_id) REFERENCES `group`(group_id),
    FOREIGN KEY(account_id) REFERENCES `account`(account_id)
);
-- Add data Group_account
INSERT INTO `group_account`(group_id, account_id, join_date)
VALUES		(1,1,"2021-10-17"),
			(2,5,"2021-10-17"),
			(3,3,"2021-10-17"),
            (4,4,"2021-10-17"),
            (5,2,"2021-10-17"),
            (6,5,"2021-10-17"),
            (7,NULL,"2021-10-17"),
			(8,NULL,"2021-10-17"),
            (9,NULL,"2021-10-17"),
            (10,NULL,"2021-10-17"),
            (11,NULL,"2021-10-17"),
            (12,NULL,"2021-10-17"),
            (13,NULL,"2021-10-17"),
            (14,NULL,"2021-10-17"),
            (15,NULL,"2021-10-17");
            
-- Type Question
CREATE TABLE type_question(
	type_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	type_name	ENUM('Essay','Multiple-Choise')
);
-- Add data Type_Question
INSERT INTO type_question(type_name)
VALUES		('Multiple-Choise'),
			('Essay');

-- Category_Question
CREATE TABLE category_question(
	category_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	category_name	VARCHAR(30) CHAR SET utf8mb4
);
-- Add data Category_Question
INSERT INTO category_question(category_name)
VALUES		('TOÁN SỐ HỌC CƠ BẢN'),
			('TOÁN HÌNH HỌC CƠ BẢN'),
			('VẬT LÝ CƠ BẢN'),
            ('HÓA HỌC CƠ BẢN'),
            ('TIN HỌC CƠ BẢN'),
            ('TOÁN SỐ HỌC NÂNG CAO'),
			('TOÁN HÌNH HỌC NÂNG CAO'),
			('VẬT LÝ CƠ BẢN NÂNG CAO'),
            ('HÓA HỌC NÂNG CAO'),
            ('TIN HỌC NÂNG CAO'),
            ('TOÁN SỐ HỌC NÂNG CAO 2'),
			('TOÁN HÌNH HỌC NÂNG CAO 2'),
			('VẬT LÝ CƠ BẢN NÂNG CAO 2'),
            ('HÓA HỌC NÂNG CAO 2'),
            ('TIN HỌC NÂNG CAO 2');
            
-- Question
CREATE TABLE question(
	question_id		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	content			VARCHAR(1000) CHAR SET utf8mb4,
    category_id		INT UNSIGNED,
    type_id			INT UNSIGNED,
	creator_id		INT UNSIGNED,
    create_date		DATE,
    FOREIGN KEY(creator_id) REFERENCES `account`(account_id)
);
-- Add data Category_Question
INSERT INTO question(content, category_id, type_id, creator_id, create_date)
VALUES		('1 + 1 = ?',1,1,1,"2021-10-17"),
			('Hình tam giác có mấy cạnh ?',2,1,1,"2021-10-17"),
            ('Nước sôi ở bao nhiêu độ ?',3,1,1,"2021-10-17"),
            ('Ký hiệu hóa học của sắt là gì ?',4,1,1,"2021-10-17"),
            ('Bộ phận nào được ví như bộ não của máy tính ?',5,1,1,"2021-10-17"),
            ('11 x 11 = ?',6,1,1,"2021-10-17"),
            ('Công thức tính diện tích hình tam giác là gì ?',7,1,1,"2021-10-17"),
            ('Khi ánh sáng đi vào môi trường khác và bị lệch hướng gọi là hiện tượng gì ?',8,1,1,"2021-10-17"),
            ('Thành phần cấu tạo của hầu hết của các loại nguyên tử gồm những gì ?',9,1,1,"2021-10-17"),
            ('Bộ nhớ RAM và ROM là bộ nhớ gì ?',10,1,1,"2021-10-17"),
            ('111 x 111 = ?',11,1,1,"2021-10-17"),
            ('Đâu là định lý Pitago trong tam giác vuông ?',12,1,1,"2021-10-17"),
            ('Ảnh của một vật khi soi qua gương được gọi là gì ?',13,1,1,"2021-10-17"),
            ('Công thức hóa học của Axit Sulfuric ?',14,1,1,"2021-10-17"),
            ('1Mb = ? Kb',15,1,1,"2021-10-17");

-- Answer
CREATE TABLE answer(
	answer_id		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	content			VARCHAR(1000),
    question_ID		INT UNSIGNED,
    is_correct		BOOLEAN,
    FOREIGN KEY(question_id) REFERENCES question(question_id)
);
-- Add Answer
INSERT INTO answer(content, question_id, is_correct)
VALUES		('2',1,1),
			('3',2,1),
            ('100 độ C',3,1),
            ('Fe',4,1),
            ('CPU',5,1),
			('121',6,1),
            ('S = (a x h)/2',7,1),
            ('Khúc xạ',8,1),
            ('Proton, notron, electron',9,1),
            ('Primary memory',10,1),
            ('12321',11,1),
            ('Bình phương cạnh huyền bằng tổng bình phương của hai cạnh còn lại',12,1),
            ('Ảnh ảo',13,1),
            ('H2SO4',14,1),
            ('1024 Kb',15,1);
            
-- Exam
CREATE TABLE exam(
	exam_id			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`code`			SMALLINT NOT NULL UNIQUE,
	title			VARCHAR(100) CHAR SET utf8mb4,
    category_id		TINYINT UNSIGNED,
    duration		INT,
    creator_id		INT UNSIGNED,
    create_date		DATE,
    FOREIGN KEY(creator_id) REFERENCES `account`(account_id),
    FOREIGN KEY(category_id) REFERENCES category_question(category_id)
);
-- Add Exam
INSERT INTO exam(`code`, title, category_id, duration, creator_id, create_date)
VALUES  	(1111, 'TEST TRÌNH ĐỘ TOÁN SỐ HỌC', 1, 60, 1, "2021-10-17"),
			(1112, 'TEST TRÌNH ĐỘ TOÁN HÌNH HỌC', 2, 60, 1, "2021-10-17"),
            (1113, 'TEST TRÌNH ĐỘ VẬT LÝ', 3, 60, 1, "2021-10-17"),
            (1114, 'TEST TRÌNH ĐỘ HÓA HỌC', 4, 60, 1, "2021-10-17"),
            (1115, 'TEST TRÌNH ĐỘ TIN HỌC', 5, 60, 1, "2021-10-17"),
			(1116, 'TEST TOÁN SỐ HỌC NÂNG CAO', 6, 60, 1, "2021-10-17"),
            (1117, 'TEST TOÁN HÌNH HỌC NÂNG CAO', 7, 60, 1, "2021-10-17"),
            (1118, 'TEST VẬT LÝ NÂNG CAO', 8, 60, 1, "2021-10-17"),
            (1119, 'TEST HÓA HỌC NÂNG CAO', 9, 60, 1, "2021-10-17"),
            (1120, 'TEST TIN HỌC NÂNG CAO ', 10, 60, 1, "2021-10-17"),
            (1121, 'TEST TOÁN SỐ HỌC NÂNG CAO 2', 11, 60, 1, "2021-10-17"),
            (1122, 'TEST TOÁN HÌNH HỌC NÂNG CAO 2', 12, 60, 1, "2021-10-17"),
            (1123, 'TEST VẬT LÝ NÂNG CAO 2', 13, 60, 1, "2021-10-17"),
            (1124, 'TEST HÓA HỌC NÂNG CAO 2', 14, 60, 1, "2021-10-17"),
            (1125, 'TEST TIN HỌC NÂNG CAO 2', 15, 60, 1, "2021-10-17");
-- ExamQuestion
CREATE TABLE exam_question(
	exam_id			SMALLINT UNSIGNED,
	question_id		INT UNSIGNED,
    FOREIGN KEY(exam_id) REFERENCES exam(exam_id),
    FOREIGN KEY(question_id) REFERENCES question(question_id)
);
-- Add Exam Question
INSERT INTO exam_question(exam_id, question_id)
VALUES		(1,1),
			(2,2),
            (3,3),
            (4,4),
            (5,5),
            (6,6),
            (7,7),
            (8,8),
            (9,9),
            (10,10),
            (11,11),
            (12,12),
            (13,13),
            (14,14),
            (15,15);

