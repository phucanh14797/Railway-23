DROP DATABASE IF EXISTS Fresher_Training_Management;
CREATE DATABASE Fresher_Training_Management;
USE Fresher_Training_Management;

ALTER DATABASE Fresher_Training_Management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 

CREATE TABLE trainee(
	trainee_id 			MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fullname 			VARCHAR(100) CHAR SET utf8mb4,
    birthdate			DATE NOT NULL,
    gender				ENUM('Male','Female','Unknown'),
    et_eq				TINYINT CHECK(et_eq>=0 AND et_eq<=20),
    et_gmath			TINYINT CHECK(et_gmath>=0 AND et_gmath<=50),
    et_english			TINYINT CHECK(et_english>=0 AND et_english<=50),
    training_class		VARCHAR(50) CHAR SET utf8mb4 NOT NULL,
    evaluation_notes	VARCHAR(255) CHAR SET utf8mb4
);

ALTER TABLE trainee ADD vti_account VARCHAR(100) NOT NULL UNIQUE; -- thêm cột VTI_Account not null & unique

-- Question 1: Thêm ít nhất 10 bản ghi vào table
INSERT INTO trainee(fullname, birthdate, gender, et_eq, et_gmath, et_english, training_class, evaluation_notes)
VALUES  ('NGUYỄN VĂN A','1990-01-01','Male',  	'10','25','18','A1',NULL), 
		('NGUYỄN VĂN B','1991-01-02','Female',	'11','27','23','A1',NULL), 
		('NGUYỄN VĂN C','1992-01-03','Female',	'12','28','22','A2',NULL),
        ('NGUYỄN VĂN D','1993-01-04','Male',	'13','30','34','A2',NULL),
        ('NGUYỄN VĂN E','1993-01-05','Female',	'14','31','50','A3',NULL),
        ('NGUYỄN VĂN F','1994-01-06','Female',	'15','33','25','A3',NULL),
        ('NGUYỄN VĂN G','1995-01-07','Male',	'16','35','22','A4',NULL),
        ('NGUYỄN VĂN H','1996-01-08','Female',	'17','37','28','A4',NULL),
        ('NGUYỄN VĂN I','1997-01-09','Female',	'18','39','35','A5',NULL),
        ('NGUYỄN VĂN K','1998-01-10','Male',	'19','40','38','A5',NULL),
        ('NGUYỄN VĂN L','1999-01-11','Female',	'20','45','40','A6',NULL);

-- Question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào, nhóm chúng thành các tháng sinh khác nhau

SELECT group_concat(full_name) AS 'group_theo_thang_sinh',month(birth_date)
FROM trainee
GROUP BY `month`(birth_date);

-- Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)
SELECT full_name,birth_date
FROM trainee
WHERE length(fullname) = (SELECT max(length(fullname))FROM trainee);

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:
--  ET_IQ + ET_Gmath>=20
--  ET_IQ>=8
--  ET_Gmath>=8
--  ET_English>=18

SELECT *
FROM trainee
WHERE et_iq + et_gmath >= 20 AND et_iq >= 8 AND et_gmath >= 8 AND et_english >= 18;

-- Question 5: xóa thực tập sinh có TraineeID = 3

DELETE
FROM trainee
WHERE trainee_id = 3;

-- Question 6: Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật thông tin vào database

UPDATE trainee
SET training_class = 2
WHERE trainee_id = 5;