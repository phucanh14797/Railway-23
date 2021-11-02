USE `testing_system_assignment`;
-- Ví dụ 1: TAO THU TUC

DROP PROCEDURE IF EXISTS sp_lay_ten_phong_theo_ma_phong; 

DELIMITER $$
CREATE PROCEDURE sp_lay_ten_phong_theo_ma_phong(in departmentID TINYINT, OUT departmentName VARCHAR(40)) -- thiết lập 
		BEGIN
			SELECT department_name INTO departmentName
            FROM department 
            WHERE department_id = departmentID;
		END$$ 
DELIMITER ;

--  Sử dụng thủ tục / gọi thủ tục
SET @ten_phong_ban = '';
CALL sp_lay_ten_phong_theo_ma_phong(1,@ten_phong_ban);
SELECT @ten_phong_ban;

SELECT * FROM sp_lay_ten_phong_theo_ma_phong;

describe department;

-- Ví dụ 2: Viết thủ tục lấy thông tin câu hỏi của tác giả có tên là 'Nguyễn Văn Thế' hoặc địa chỉ email là 'nguyenvanthe@gmail.com

describe `account` ;
describe question;


-- TAO THU TUC LAY THON TIN CAU HOI CUA TAC GIA CO TEN ... HOAC COS EMAIL...

DROP PROCEDURE IF EXISTS sp_lay_thong_tin_cau_hoi_theo_ten; -- DROP PHAI DE NGOAI DELIMITER

DELIMITER $$
CREATE PROCEDURE sp_lay_thong_tin_cau_hoi_theo_ten(IN tenTacGia varchar(50) CHAR SET utf8mb4, IN inputEmail varchar(80)) 
			BEGIN
				SELECT q.*
                FROM question q JOIN `account` ac ON q.creator_id = ac.account_id
                WHERE ac.fullname = tenTacGia OR ac.email = inputEmail; -- CHU Y DAU ';'
            END$$
DELIMITER ; 

-- GOI/ SU DUNG THU TUC   
       
CALL sp_lay_thong_tin_cau_hoi_theo_ten ('Nguyễn Văn A','');


-- Vi du

DESCRIBE department;

DROP PROCEDURE IF EXISTS sp_lay_ten_phong; 

DELIMITER $$
CREATE PROCEDURE sp_lay_ten_phong(in departmentID TINYINT) -- thiết lập 
		  BEGIN
	
			DECLARE ten_phong_ban varchar(40);
            
			SELECT department_name INTO ten_phong_ban
            FROM department 
            WHERE department_id = departmentID;
            SELECT ten_phong_ban;
        END$$ 
DELIMITER ;

CALL sp_lay_ten_phong (3);

describe `account`;
describe `position`;

DROP FUNCTION IF EXISTS f_lay_chuc_vu_nv;
 
DELIMITER $$
CREATE FUNCTION f_lay_chuc_vu_nv(maNhanVien int(10))
	RETURNS enum('Dev','Test','Scrum Master','PM','Giám đốc','Thư ký','Phó giám đốc','Trưởng phòng Marketing','Trưởng phòng Sale','Trưởng phòng Dịch vụ','Trưởng phòng Giám sát','Trưởng phòng Tài vụ','Trưởng phòng Kế hoạch','Trưởng phòng Tài chính','Trưởng phòng Pháp chế')
	BEGIN
		DECLARE tenChucVu ENUM('Dev','Test','Scrum Master','PM','Giám đốc','Thư ký','Phó giám đốc','Trưởng phòng Marketing','Trưởng phòng Sale','Trưởng phòng Dịch vụ','Trưởng phòng Giám sát','Trưởng phòng Tài vụ','Trưởng phòng Kế hoạch','Trưởng phòng Tài chính','Trưởng phòng Pháp chế') CHARSET utf8mb4;
		SELECT p.position_name INTO tenChucVu
        FROM `position` p INNER JOIN `account` acc ON p.position_id = acc.position_id
        WHERE acc.account_id = maNhanVien;
		RETURN tenChucVu;
	END $$
DELIMITER ;

SELECT f_lay_chuc_vu_nv(2);



-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

DESCRIBE department;     

DROP PROCEDURE IF EXISTS nhap_ten_pb_in_ac;
DELIMITER $$     
CREATE PROCEDURE nhap_ten_pb_in_ac(IN departmentName varchar(40) CHAR SET utf8mb4)
		BEGIN
			SELECT ac.* 
            FROM `account` ac INNER JOIN department d ON ac.department_id = d.department_id
            WHERE department_name = departmentName;
            
        END$$
DELIMITER ;

CALL nhap_ten_pb_in_ac('Sale');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group

DROP PROCEDURE IF EXISTS sp_in_sl_account;

DELIMITER $$
CREATE PROCEDURE  sp_in_sl_account()
	BEGIN
		SELECT ga.group_id , COUNT(ac.account_id)
        FROM group_account ga LEFT JOIN `account` ac ON ga.account_id = ac.account_id
		GROUP BY ga.group_id;
    END $$
DELIMITER ;

CALL sp_in_sl_account();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại

DROP PROCEDURE IF EXISTS sp_thong_ke_q_current_month;

DELIMITER $$
CREATE PROCEDURE  sp_thong_ke_q_current_month()
	BEGIN
		SELECT tq.type_name, COUNT(q.question_id)
        FROM type_question tq LEFT JOIN question q ON tq.type_id = q.type_id
		GROUP BY tq.type_name HAVING q.create_date = MONTH(getmonth());
    END $$
DELIMITER ;

CALL sp_thong_ke_q_current_month();


-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

DROP PROCEDURE IF EXISTS sp_typeid_max_ques;

DELIMITER $$
CREATE PROCEDURE  sp_typeid_max_ques()
	BEGIN   
		SELECT tq.type_name, COUNT(q.question_id)
        FROM type_question tq JOIN question q ON tq.type_id = q.type_id
		GROUP BY tq.type_name HAVING COUNT(q.question_id) = (
														SELECT MAX(count_ques)
                                                        FROM (
                                                        SELECT COUNT(q.question_id) AS count_ques
                                                        FROM type_question tq JOIN question q ON tq.type_id = q.type_id
														GROUP BY tq.type_name ) CQ ) ;
    END $$
DELIMITER ;

CALL sp_typeid_max_ques();


-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question



-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên  chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa 
--  chuỗi của người dùng nhập vào



-- Question 7: Viết 1 store cho phép ngư ời dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công

DESCRIBE `account`;
SELECT * FROM `account`;

DROP PROCEDURE IF EXISTS sp_user_input;

DELIMITER $$
CREATE PROCEDURE  sp_user_input(IN fullName VARCHAR(50) CHAR SET utf8mb4, IN inEmail VARCHAR(50))
	BEGIN   
		DECLARE userName VARCHAR(50) DEFAULT SUBSTRING_INDEX(inEmail,'@',1);
        DECLARE departmentID TINYINT UNSIGNED DEFAULT 8;
        DECLARE positionID TINYINT UNSIGNED DEFAULT 1;
        DECLARE createDate DATETIME DEFAULT CURDATE();
        INSERT INTO `account` (email, username, fullname, department_id, position_id, create_date) VALUES
        (inEmail, userName,fullName, departmentID, positionID, createDate);
        SELECT * FROM `account` ORDER BY account_id DESC LIMIT 1;
    END $$
DELIMITER ;

CALL sp_user_input('TRAN VAN A','tranvana@gmail.com');

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

DESCRIBE type_question;

DROP PROCEDURE IF EXISTS sp_thong_ke_type_ques;

DELIMITER $$
CREATE PROCEDURE  sp_thong_ke_type_ques(IN inType ENUM('Essay','Multiple-Choise'))
	BEGIN   
        SELECT tq.type_name, q.question_id, q.content
        FROM question q JOIN type_question tq ON q.type_id = tq.type_id
        WHERE length(q.content) = (SELECT MAX(length(content))
									FROM question
                                    )
		AND inType = tq.type_name ;
	END $$
DELIMITER ;

CALL sp_thong_ke_type_ques ('Multiple-Choise');

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DESCRIBE exam;

DROP PROCEDURE IF EXISTS xoa_exam_tren_id;

DELIMITER $$
CREATE PROCEDURE xoa_exam_tren_id(IN exId smallint(5) unsigned)
	BEGIN
		DELETE 
        FROM exam
        WHERE exam_id = exID;
    END $$
DELIMITER ;

CALL xoa_exam_tren_id(1);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử 
--  dụng store ở câu 9 để xóa)
--  Sau đó in số lượng record đã remove từ các table liên quan trong khi 
--  removing
-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng 
--  nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được 
--  chuyển về phòng ban default là phòng ban chờ việc
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm 
--  nay
-- 2
-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 
--  tháng gần đây nhất
--  (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong 
-- tháng")

        


      
		




