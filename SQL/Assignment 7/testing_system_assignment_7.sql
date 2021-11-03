USE testing_system_assignment;
-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước

DELIMITER $$
create trigger trigger_check_insert_group
	before insert on `group`
	for each row
	begin
		declare targetCreateDate date;
        select date_sub(curdate(), interval 1 year) into targetCreateDate;
			if NEW.create_date < targetCreateDate then
			signal sqlstate '12345'
            set message_text = 'Ngày tạo không hợp lệ';
			end if;
	end $$
DELIMITER ;

select * from `group`;
INSERT INTO `group`(group_name, creator_id, create_date) 
VALUES 
	('TEST',1, '2020-11-11');


-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào 
--  department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
--  "Sale" cannot add more user"

DELIMITER $$
create trigger trigger_check_add_sale
	before insert on `account`
    for each row
    begin
		declare idSale tinyint;
        select department_id into idSale
        from department
        where department_name = 'Sale';
			if new.department_id = idSale then
			signal sqlstate '12345'
            set message_text = 'Department "Sale" cannot add more user';
			end if;
    end $$
DELIMITER ;

INSERT INTO `account`(email, username, fullname, department_id, position_id, create_date) 
VALUES 
	();
    

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user

DELIMITER $$

create trigger trigger_group_max_5
before insert on `group_account`
for each row 
begin 
	declare count_acc tinyint;
    select count(account_id) into count_acc
    from group_account ga
    where group_id = new.group_id group by group_id;
    if count_acc >= 5 then signal sqlstate '12345' set message_text = 'Nhóm vượt quá số lượng thành viên';
    end if;
end $$

DELIMITER ;

    
-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question

DELIMITER $$

create trigger trigger_check_exam_ques
before insert on exam_question
for each row 
	begin
		declare count_ques tinyint;
        select count(question_id) into count_ques
        from exam_question
        where exam_id = new.exam_id group by exam_id;
        if count_ques > 10 then signal sqlstate '12345' set message_text = 'Vượt quá số câu hỏi trong một đề thi';
        end if;
    end $$

DELIMITER ;

-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là 
--  admin@gmail.com (đây là tài khoản admin, không cho phép user xóa), 
--  còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông 
--  tin liên quan tới user đó

DELIMITER $$

create trigger trigger_check_delete_admin
before delete on `account`
for each row
	begin 
		select *
        from `account`;
        if old.email = 'admin@gmail.com' then signal sqlstate '12345' set message_text = 'Không thể xóa quản trị viên';
        end if;
    end $$

DELIMITER ;


-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table 
--  Account, hãy tạo trigger cho phép người dùng khi tạo account không điền 
--  vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
 insert into department(department_name)
 values ('Waiting Department');

DELIMITER $$
create trigger trigger_set_default_department_for_null
before insert on `account`
for each row
		begin
			if new.department_id is null 
            then set new.department_id = (select department_id from department where department_name = 'Waiting Department');
            end if;
        end $$

DELIMITER ;

-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi 
--  question, trong đó có tối đa 2 đáp án đúng.

DELIMITER $$

CREATE TRIGGER trigger_check_answer
	BEFORE INSERT ON answer
	FOR EACH ROW 	 
    BEGIN
		
		DECLARE count_answer tinyint;
        DECLARE count_is_correct tinyint;
        
        -- DEM ANSWER
        SELECT COUNT(answer_id) INTO count_answer
        FROM answer
        WHERE question_id = NEW.question_id;
        
        -- DEM IS CORRECT TRUE
        
        SELECT COUNT(is_correct) INTO count_is_correct
        FROM answer
        WHERE question_id = NEW.question_id AND is_correct = 1;
        
        -- CHECK
        
        IF count_answer >=4 OR (count_is_correct >= 2 AND NEW.is_correct = 1 )
        THEN SIGNAL SQLSTATE '1234' SET MESSAGE_TEXT = ' Vượt quá giới hạn nhập ';
        END IF;
        
    END $$
    
DELIMITER ;


-- Question 8: Viết trigger sửa lại dữ liệu cho đúng: 
--  Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định 
--  Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database


DROP TRIGGER IF EXISTS trigger_check_gender;
DELIMITER $$
CREATE TRIGGER trigger_check_gender
 BEFORE INSERT ON `account`
 FOR EACH ROW
	BEGIN

		IF NEW.gender = 'Nam' THEN 
		SET NEW.gender = 'M';
		END IF;
		
		IF NEW.gender = 'Nữ' THEN 
		SET NEW.gender = 'F';
		END IF;
		
		IF NEW.gender = 'Chưa xác định' THEN 
		SET NEW.gender = 'U';
		END IF;
		
	END $$
DELIMITER ;

-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS trigger_check_2_ngay;
DELIMITER $$
CREATE TRIGGER trigger_check_2_ngay
	BEFORE DELETE ON `exam`
    FOR EACH ROW 
		BEGIN 
			DECLARE before2days DATE; -- biến chứa 2 ngày trước
            SELECT DATE_SUB(CURDATE(),INTERVAL 2 DAY) INTO before2days;
            IF OLD.create_date > before2days THEN SIGNAL SQLSTATE '12345'
            SET message_text = 'CANT NOT DELETE EXAM';
            END IF;
        END $$
DELIMITER ;


-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các 
--  question khi question đó chưa nằm trong exam nào


DELIMITER $$
CREATE TRIGGER trigger_update_exam_limit
	BEFORE UPDATE ON question
    FOR EACH ROW 
		BEGIN
			DECLARE count_exam INT;
            SELECT COUNT(exam_id) INTO count_exam
            FROM exam_question 
            WHERE question_id = OLD.question_id;
            IF count_exam <> 0 THEN SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'CANT NOT UPDATE';
            END IF;
        END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trigger_delete_exam_limit
	BEFORE DELETE ON question
    FOR EACH ROW 
		BEGIN
			DECLARE count_exam INT;
            SELECT COUNT(exam_id) INTO count_exam
            FROM exam_question 
            WHERE question_id = OLD.question_id;
            IF count_exam <> 0 THEN SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'CANT NOT DELETE';
            END IF;
        END $$
DELIMITER ;



-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"

SELECT exam_id, CASE WHEN duration <= '00:30:00' THEN 'short time'
when duration > '00:30:00' AND duration <= '00:60:00' THEN 'medium time'
when duration > '00:60:00' THEN 'long time' END AS Duration
FROM exam ;



-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên 
--  là the_number_user_amount và mang giá trị được quy định như sau:

-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher

SELECT g.group_name, COUNT(ga.account_id), 
CASE 
	 WHEN COUNT(ga.account_id) <= 5 THEN 'few' 
	 WHEN COUNT(ga.account_id) > 5 AND COUNT(ga.account_id) <= 20 THEN 'normal' 
	 WHEN COUNT(ga.account_id) > 20 THEN 'higher' 
END 
AS the_number_user_amount

FROM `group` g LEFT JOIN group_account ga ON g.group_id = ga.group_id
GROUP BY g.group_id;


-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào 
--  không có user thì sẽ thay đổi giá trị 0 thành "Không có User"

SELECT d.department_name,
	CASE WHEN COUNT(ac.account_id) = 0 THEN 'Không có User'
	ELSE COUNT(ac.account_id)
	END
AS so_user
FROM department d LEFT JOIN `account` ac ON d.department_id = ac.department_id
GROUP BY d.department_id;

