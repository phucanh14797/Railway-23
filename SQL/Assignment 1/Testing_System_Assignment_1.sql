CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;

-- Department
CREATE TABLE Department( 
	Department_ID  	INT,
    Department_Name VARCHAR(100)
); 
-- Poisition
CREATE TABLE `Position`(
	Position_ID		INT,
    Position_Name	ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);
-- Account
CREATE TABLE `Account`(
	Account_ID		INT,
    Email			VARCHAR(100),
    Username		VARCHAR(100),
    FullName		VARCHAR(100),
    Department_ID	INT,
    Position_ID		INT,
    Create_Date		DATE
);
-- Group
CREATE TABLE `Group`(
	Group_ID 	INT,
    Group_Name	VARCHAR(100),
    Creator_ID	INT,
    Create_Date	DATE
);
-- GroupAccount
CREATE TABLE Group_Account(
	Group_ID	INT,
	Account_ID	INT,	
	Join_Date 	DATE
);
-- Type Question
CREATE TABLE Type_Question(
	Type_ID		INT,
	Type_Name	ENUM('Essay','Multiple-Choise')
);
-- CategoryQuestion
CREATE TABLE Category_Question(
	Category_ID		INT,
	Category_Name	VARCHAR(100)
);
-- Question
CREATE TABLE Question(
	Question_ID		INT,
	Content			VARCHAR(1000),
    Category_ID		INT,
    Type_ID			INT,
	Creator_ID		INT,
    Create_Date		DATE
);
-- Answer
CREATE TABLE Answer(
	Answer_ID		INT,
	Content			VARCHAR(1000),
    Question_ID		INT,
    is_Correct		BOOLEAN
);
-- Exam
CREATE TABLE Exam(
	Exam_ID			INT,
	`Code`			INT,
	Title			VARCHAR(255),
    Category_ID		INT,
    Duration		INT,
    Creator_ID		INT,
    Create_Date		DATE
);
-- ExamQuestion
CREATE TABLE Exam_Question(
	Exam_ID			INT,
	Question_ID		INT
);