USE `testing_system_assignment_3`;

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT * FROM `group`;

SELECT group_name
FROM `group`
WHERE create_date < 2019-12-20;

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT * FROM answer; 

SELECT question_id, COUNT(question_id) AS 'Tổng số câu trả lời' -- đếm số question id lặp lại trong 1 bảng
FROM answer
GROUP BY question_id HAVING COUNT(question_id) >= 4;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT * FROM exam;

SELECT `code`
FROM exam
WHERE duration >= 60 AND create_date < 2019-12-20;

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `group`;

SELECT *
FROM `group`
LIMIT 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT * FROM `account`;

SELECT COUNT(fullname)
FROM `account`
WHERE department_id = 2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT * FROM `account`;

SELECT fullname
FROM `account`
WHERE fullname LIKE 'D%o';


-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
SELECT * FROM exam;

DELETE 
FROM exam
WHERE create_date < "2019-12-20";

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
SELECT * FROM question;

DELETE
FROM question
WHERE content LIKE 'câu hỏi %';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
SELECT * FROM `account`;

UPDATE `account`
SET fullname = 'NGUYỄN BÁ LỘC',
	email = 'loc.nguyenba@vti.com.vn'
WHERE account_id = 5;


-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
SELECT* FROM group_account;

UPDATE group_account
SET group_id = 4
WHERE account_id = 5;
