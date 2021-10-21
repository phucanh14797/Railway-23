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