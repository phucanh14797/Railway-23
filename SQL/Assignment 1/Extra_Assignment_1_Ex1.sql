DROP DATABASE IF EXISTS Fresher_Training_Management;
CREATE DATABASE Fresher_Training_Management;
USE Fresher_Training_Management;
CREATE TABLE Fresh_trainee (
	TraineeID 			MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    VTI_Account			MEDIUMINT NOT NULL UNIQUE KEY,
    FullName 			VARCHAR(100),
    BirthDate			DATE,
    Gender				ENUM('Male','Female','Unknown'),
    ET_EQ				TINYINT CHECK(ET_EQ>=0 AND ET_EQ<=20),
    ET_Gmath			TINYINT CHECK(ET_Gmath>=0 AND ET_Gmath<=50),
    ET_English			TINYINT CHECK(ET_English>=0 AND ET_English<=50),
    Training_Class		SMALLINT,
    Evaluation_Notes	VARCHAR(100)
);