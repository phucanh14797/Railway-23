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
        if email = 'admin@gmail.com' then signal sqlstate '12345' set message_text = 'Không thể xóa quản trị viên';
        end if;
    end $$

DELIMITER ;


-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table 
--  Account, hãy tạo trigger cho phép người dùng khi tạo account không điền 
--  vào departmentID thì sẽ được phân vào phòng ban "waiting Department"



-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi 
--  question, trong đó có tối đa 2 đáp án đúng.
-- Question 8: Viết trigger sửa lại dữ liệu cho đúng: 
--  Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định 
--  Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các 
--  question khi question đó chưa nằm trong exam nào
-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"
-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên 
--  là the_number_user_amount và mang giá trị được quy định như sau:
-- 2
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào 
--  không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
