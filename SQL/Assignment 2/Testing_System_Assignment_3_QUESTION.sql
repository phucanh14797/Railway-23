USE testing_system_assignment_3;

-- QUESTION 2: LẤY RA TẤT CẢ PHÒNG BAN
SELECT department.department_name
FROM department;

-- QUESTION 3: LẤY RA ID PHÒNG BAN "SALE"
SELECT department.department_id
FROM department
WHERE department_name = 'sale';

-- QUESTION 4: LẤY RA THÔNG TIN ACCOUNT CÓ FULLNAME DÀI NHẤT
SELECT *
FROM `account` 
WHERE LENGTH(fullname) = (
	SELECT MAX(LENGTH(fullname))
    FROM `account`);

-- QUESTION 5: LẤY RA THÔNG TIN ACCOUNT CÓ FULLNAME DÀI NHẤT & ID=3
SELECT *
FROM `account` 
WHERE LENGTH(fullname) = (
	SELECT MAX(LENGTH(fullname))
    FROM `account`) 
AND account_id = 3;