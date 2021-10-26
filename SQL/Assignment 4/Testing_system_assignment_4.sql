USE `testing_system_assignment_3`;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT * FROM `account`;

SELECT `account`.fullname, department.department_id, department.department_name
FROM `account` JOIN department ON `account`.department_id = department.department_id;         

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
SELECT * FROM `account`;

SELECT `account`.*
FROM `account`
WHERE create_date > 2010-12-20;

-- Question 3: Viết lệnh để lấy ra tất cả các developer 
SELECT * FROM `account`;

SELECT `account`.fullname 
FROM `account` JOIN `position` ON `account`.position_id = `position`.position_id
WHERE position_name = 'Dev';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT * FROM `account`;

SELECT department.department_id, count(department.department_id) as 'Số nhân viên có trong phòng' -- thêm đếm số để kiểm tra
FROM `account` INNER JOIN department ON `account`.department_id = department.department_id
GROUP BY department.department_id HAVING (COUNT(department.department_id)) > 3;                   


-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT * FROM  exam_question;

SELECT COUNT(eq.question_id) AS 'Số lần xuất hiện', q.content -- thêm cột COUNT để kiểm tra 
FROM question q 
JOIN exam_question eq ON eq.question_id = q.question_id
GROUP BY q.question_id 
HAVING COUNT(eq.question_id) = (
	SELECT MAX(exam_count)
    FROM (
		SELECT COUNT(eq.question_id) AS exam_count
        FROM exam_question eq
        GROUP BY eq.question_id
    ) M
	    
);
        
-- Question 6: Thông kê mỗi Category Question được sử dụng trong bao nhiêu QUESTION
SELECT * FROM question;
SELECT * FROM category_question;

SELECT cq.category_name , count(q.question_id) AS 'Số lần được sử dụng' -- thêm cột COUNT để kiểm tra
FROM question q 
RIGHT JOIN category_question cq ON q.category_id = cq.category_id
GROUP BY cq.category_id;

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

SELECT `group`.group_name, COUNT(group_account.account_id) AS 'Số lượng Account trong nhóm'
FROM group_account 
JOIN `group` ON `group`.group_id = group_account.group_id
GROUP BY group_account.account_id;

-- Question 10: Tìm chức vụ có ít người nhất 
-- Nghĩa là tìm số position id xuất hiện ít nhất tham chiếu bảng position và lấy tên của chức vụ

SELECT position_name AS 'Chức vụ', COUNT(`account`.position_id) AS 'Số người'
FROM `position` 
JOIN `account` ON `account`.position_id = `position`.position_id
GROUP BY `account`.position_id 
HAVING COUNT(`account`.position_id) = (
	SELECT MIN(Mi.account_count)
    FROM 
		(SELECT COUNT(`position`.position_id) AS account_count
		 FROM  `account` RIGHT JOIN `position` ON `account`.position_id = `position`.position_id
         GROUP BY `position`.position_id
        ) Mi
);

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT * FROM `account`;

SELECT department.department_name,`position`.position_name, COUNT(`position`.position_id) 'Số người'
FROM `account` 
RIGHT JOIN department ON `account`.department_id = department.department_id
RIGHT JOIN `position` ON `position`.position_id = `account`.position_id
GROUP BY `position`.position_id;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì,

SELECT * FROM question;

SELECT q.question_id, q.content'Question', cq.category_name'Category', tq.type_name 'Type', ac.Fullname 'Creator', an.content 'Answer'
FROM question q
LEFT JOIN category_question cq ON q.category_id = cq.category_id
LEFT JOIN type_question tq     ON q.type_id = tq.type_id
LEFT JOIN `account`	ac		   ON q.creator_id = ac.account_id
LEFT JOIN answer an			   ON q.question_id = an.question_id;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

SELECT tq.type_name, COUNT(q.question_id)
FROM type_question tq LEFT JOIN question q ON tq.type_id = q.type_id
GROUP BY tq.type_id;

-- Question 14:Lấy ra group không có account nào

SELECT gr.group_name
FROM `group` gr
RIGHT JOIN group_account ga  ON gr.group_id = ga.group_id
WHERE ga.account_id IS NULL;

-- Question 15: Lấy ra group không có account nào

SELECT gr.group_name
FROM `group` gr
RIGHT JOIN group_account ga  ON gr.group_id = ga.group_id
WHERE ga.account_id IS NULL;

-- Question 16: Lấy ra question không có answer nào

SELECT q.content
FROM question q
LEFT JOIN answer an ON q.question_id = an.question_id
WHERE an.content IS NULL;

-- Exercise 2: Union

-- Question 17: 

-- a) Lấy các account thuộc nhóm thứ 1
SELECT * FROM group_account;

SELECT ac.*
FROM group_account ga JOIN `account` ac ON ga.account_id = ga.account_id
WHERE group_id = 1;

-- b) Lấy các account thuộc nhóm thứ 2

SELECT ac.*
FROM group_account ga JOIN `account` ac ON ga.account_id = ga.account_id
WHERE group_id = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau

SELECT ac.*
FROM group_account ga JOIN `account` ac ON ga.account_id = ga.account_id
WHERE group_id = 1
		UNION
SELECT ac.*
FROM group_account ga JOIN `account` ac ON ga.account_id = ga.account_id
WHERE group_id = 2;



-- Question 18: 

-- a) Lấy các group có lớn hơn 5 thành viên

SELECT gr.group_id
FROM group_account ga JOIN `group` gr ON ga.group_id = gr.group_id
GROUP BY ga.group_id HAVING COUNT(ga.account_id) > 5;
 

-- b) Lấy các group có nhỏ hơn 7 thành viên

SELECT gr.group_id
FROM group_account ga RIGHT JOIN `group` gr ON ga.group_id = gr.group_id
GROUP BY ga.group_id HAVING COUNT(ga.account_id) < 7;
 

-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT gr.group_id
FROM group_account ga JOIN `group` gr ON ga.group_id = gr.group_id
GROUP BY ga.group_id HAVING COUNT(ga.account_id) > 5
		UNION ALL
SELECT gr.group_id
FROM group_account ga RIGHT JOIN `group` gr ON ga.group_id = gr.group_id
GROUP BY ga.group_id HAVING COUNT(ga.account_id) < 7;
