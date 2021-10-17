DROP DATABASE IF EXISTS testing_system_assignment_1;
CREATE DATABASE testing_system_assignment_1;
USE testing_system_assignment_1;

-- Department
CREATE TABLE Department ( 
	DepartmentID  		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName    	VARCHAR(30) UNIQUE KEY
); 
-- Poisition
CREATE TABLE `Position` (
	PositionID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName	ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);
-- Account
CREATE TABLE `Account` (
	AccountID		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email			VARCHAR(100) UNIQUE KEY,
    Username		VARCHAR(100) UNIQUE KEY,
    FullName		VARCHAR(100),
    DepartmentID	INT UNSIGNED,
    PositionID		TINYINT UNSIGNED,
    CreateDate		DATE,
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);
-- Group
CREATE TABLE `Group` (
	GroupID 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName		VARCHAR(100),
    CreatorID		INT UNSIGNED,
    CreateDate		DATE,
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);
-- GroupAccount
CREATE TABLE GroupAccount (
	GroupID			INT UNSIGNED,
	AccountID		INT UNSIGNED,	
	JoinDate 		DATE,
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);
-- Type Question
CREATE TABLE TypeQuestion (
	TypeID			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	TypeName		ENUM('Essay','Multiple-Choise')
);
-- CategoryQuestion
CREATE TABLE CategoryQuestion (
	CategoryID			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	CategoryName		VARCHAR(30)
);
-- Question
CREATE TABLE Question (
	QuestionID			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content				VARCHAR(100),
    CategoryID			INT UNSIGNED,
    TypeID				INT UNSIGNED,
	CreatorID			INT UNSIGNED,
    CreateDate			DATE,
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);
-- Answer
CREATE TABLE Answer (
	AnswerID			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content				VARCHAR(100),
    QuestionID			INT UNSIGNED,
    isCorrect			ENUM('Correct','NOT Correct'),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);
-- Exam
CREATE TABLE Exam (
	ExamID				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`Code`				INT UNSIGNED,
	Title				VARCHAR(100),
    CategoryID			INT UNSIGNED,
    Duration			TIME,
    CreatorID			INT UNSIGNED,
    CreateDate			DATE,
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID)
);
-- ExamQuestion
CREATE TABLE ExamQuestion (
	ExamID				INT UNSIGNED,
	QuestionID			INT UNSIGNED,
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);