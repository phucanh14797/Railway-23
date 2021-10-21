USE `testing_system_assignment_3`;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ

SELECT `account`.fullname, department.department_name
FROM `account` JOIN department ON `account`.department_id = department.department_id;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
SELECT * FROM `account`;

SELECT `account`.*
FROM `account`
WHERE create_date < 2010-12-20;

-- Question 3: Viết lệnh để lấy ra tất cả các developer 
SELECT * FROM `account`;
SELECT `account`.* ,`position`.position_name
FROM `account` JOIN `position` ON `account`.position_id = `position`.position_id
WHERE position_name = 'Dev';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT * FROM `account`;

SELECT department_name, count(department_name) as 'Số nhân viên có trong phòng'
FROM `account` JOIN department ON `account`.department_id = department.department_id
GROUP BY department_name HAVING (COUNT(department_name)) > 3;


-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT * FROM  exam_question;

SELECT COUNT(content), content
FROM question JOIN exam_question ON exam_question.question_id = question.question_id
GROUP BY content
ORDER BY COUNT(content) DESC   
LIMIT 5;    

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT * FROM question;

SELECT category_name, count(question.category_id)
FROM question JOIN category_question ON question.category_id = category_question.category_id
GROUP BY question.category_id;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam

SELECT question.content, COUNT(exam_question.question_id)
FROM question JOIN exam_question ON question.question_id = exam_question.question_id
GROUP BY question.content;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất

SELECT question.content, count(answer.question_id) as 'Số câu trả lời'
FROM question JOIN answer ON question.question_id = answer.question_id
GROUP BY answer.question_id
ORDER BY COUNT(answer.question_id) DESC
LIMIT 1;

-- Question 9: Thống kê số lượng account trong mỗi group 

SELECT group_account.group_id, `group`.group_name , COUNT(group_account.account_id) AS 'Số lượng Account trong nhóm'
FROM group_account JOIN `account` ON `account`.account_id = group_account.account_id
JOIN `group` ON `group`.group_id = group_account.group_id
GROUP BY group_account.account_id
ORDER BY group_account.group_id; -- Sắp xếp id theo thứ tự lớn bé

-- Question 10: Tìm chức vụ có ít người nhất 
-- Nghĩa là tìm số position id xuất hiện ít nhất tham chiếu bảng position và lấy tên của chức vụ
SELECT position_name AS 'Chức vụ', COUNT(`account`.position_id) AS 'Số người'
FROM `position` JOIN `account` ON `account`.position_id = `position`.position_id
GROUP BY `account`.position_id
ORDER BY `account`.position_id DESC LIMIT 1; -- Sắp xếp chức vụ theo thứ tự bé đến lớn và dùng limit xác định chức vụ ít người nhất


-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT * FROM `account`;

SELECT `account`.fullname, department.department_name,`position`.position_name 
FROM `account` JOIN department ON `account`.department_id = department.department_id
JOIN `position` ON `position`.position_id = `account`.position_id



-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì,

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

-- Question 14:Lấy ra group không có account nào

-- Question 15: Lấy ra group không có account nào

-- Question 16: Lấy ra question không có answer nào

-- Exercise 2: Union
-- Question 17: 
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
-- Question 18: 
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b)
