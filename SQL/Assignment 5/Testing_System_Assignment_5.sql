USE `testing_system_assignment_3`;
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale

CREATE VIEW v_nhan_vien_phong_sales AS(
			SELECT ac.fullname
            FROM `account` ac JOIN department d ON ac.department_id = d.department_id
            WHERE d.department_name = (
					SELECT d.department_name
					FROM department d
					WHERE d.department_id = 2
					)
		
);

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
select *
from group_account;

DROP VIEW IF EXISTS v_account_tham_gia_nhieu_group;
CREATE VIEW v_account_tham_gia_nhieu_group AS(
			SELECT ac.fullname, COUNT(ga.group_id)
            FROM `account` ac JOIN group_account ga ON ac.account_id = ga.account_id
            GROUP BY ac.account_id HAVING COUNT(ga.group_id) = (
								 			SELECT MAX(tim_max)
											FROM ( 
													SELECT COUNT(ga.group_id) AS tim_max
													FROM group_account ga JOIN `account` ac ON ac.account_id = ga.account_id
													GROUP BY ac.fullname) max)
);

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi

DROP VIEW IF EXISTS v_cau_hoi_dai_qua_300;
CREATE VIEW v_cau_hoi_dai_qua_300 AS(
			SELECT q.content
            FROM question q 
            WHERE LENGTH(content) - LENGTH(REPLACE(content, ' ', '')) + 1 > 300
);
DELETE FROM v_cau_hoi_dai_qua_300;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

DROP VIEW IF EXISTS v_danh_sach_phong_ban_nhieu_nv;
CREATE VIEW v_danh_sach_phong_ban_nhieu_nv AS(
			SELECT d.department_name, COUNT(ac.account_id)
            FROM department d JOIN `account` ac ON ac.department_id = d.department_id
            GROUP BY ac.department_id HAVING COUNT(ac.account_id) = (
											SELECT MAX(tim_max)
											FROM ( 
													SELECT COUNT(ac.account_id) AS tim_max
													FROM `account` ac
													GROUP BY ac.department_id) max)
);

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo

DROP VIEW IF EXISTS v_cau_hoi_user_ho_Nguyen;
CREATE VIEW v_cau_hoi_user_ho_Nguyen AS (
			SELECT q.content, ac.fullname
            FROM question q JOIN `account` ac ON ac.account_id = q.creator_id
            WHERE ac.fullname IN (
				SELECT ac.fullname
                FROM `account`
                WHERE ac.fullname LIKE 'NGUYEN%'
                )
);
SELECT * FROM v_cau_hoi_user_ho_Nguyen;
