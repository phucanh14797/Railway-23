DROP DATABASE IF EXISTS RDBMS;

CREATE DATABASE IF NOT EXISTS RDBMS;
USE RDBMS;

drop table if exists customer;
create table customer(
	CustomerID int primary key auto_increment,
    `Name` varchar(30),
    Phone varchar(15),
    Email varchar(30),
    Address varchar(100),
    Note varchar(300)
);

INSERT INTO customer(`Name`, Phone, Email, Address, Note)
VALUES  ('NGUYEN VAN A', 	'111-222-333', 'a@gmail.com', 'Hanoi',		' ' ),
		('TRAN VAN B', 		'444-555-666', 'b@gmail.com', 'Ho Chi Minh',' ' ),
		('DINH THI C', 		'777-888-999', 'c@gmail.com', 'Da Nang',	' ' ),
		('CHU VAN D',		'123-456-789', 'd@gmail.com', 'Vung Tau',	' ' ),
		('CHU THU E ', 		'987-654-321', 'e@gmail.com', 'Nghe An',	' ' );

drop tables if exists car;
create table car(
	CarID int primary key,                         
	Maker enum('HONDA','TOYOTA','NISSAN'),
    Model varchar(20),
    `Year` YEAR,
    Color varchar(20),
    Note varchar(300)
);

INSERT INTO car(CarID, Maker, Model, `Year`, Color, Note)
VALUES
		(1111, 'HONDA', 	'Civic', 		 '2020', 'Black', ' '),
        (2222, 'TOYOTA', 	'Camry', 		 '2019', 'White', ' '),
        (3333, 'NISSAN', 	'City', 		 '2020', 'Red',   ' '),
        (4444, 'HONDA', 	'CRV', 			 '2019', 'Black', ' '),
        (5555, 'TOYOTA', 	'Corrola Altis', '2020', 'White', ' ');

drop table if exists car_order;
create table car_order(
	OrderID int primary key auto_increment,
    CustomerID int,
	CarID int,
    Amount int unsigned default 1,			
    SalePrice bigint unsigned,
    OrderDate date,
    DeliveryDate date,
    DeliveryAddress varchar(100),
    `Status` enum('0','1','2'),
    Note varchar(300),
	foreign key (CustomerID) references customer(CustomerID),
    foreign key (CarID) references car(CarID)
);

INSERT INTO car_order(CustomerID, CarID, Amount, SalePrice, OrderDate, DeliveryDate, DeliveryAddress, `Status`, Note)
VALUES  (1,1111,'1','600000000','2020/5/5','2020/5/10','Hanoi','1',' '),
		(2,2222,'2','900000000','2020/3/2','2020/4/1','Hanoi','1',' '),
        (3,3333,'1','600000000','2020/5/5','2020/5/10','Hanoi','1',' '),
        (4,4444,'4','800000000','2020/5/5','2020/5/10','Hanoi','1',' '),
        (5,5555,'1','700000000','2021/11/3','2021/11/10','Hanoi','0',' ');

-- 1. T???o table v???i c??c r??ng bu???c v?? ki???u d??? li???u
-- Th??m ??t nh???t 5 b???n ghi v??o table.


-- 2. Vi???t l???nh l???y ra th??ng tin c???a kh??ch h??ng: t??n, s??? l?????ng oto kh??ch h??ng ???? 
-- mua v?? s???p s???p t??ng d???n theo s??? l?????ng oto ???? mua.

SELECT * FROM customer;
SELECT * FROM car_order;

SELECT c.`name`, co.amount
FROM customer c LEFT JOIN car_order co ON c.CustomerID = co.CustomerID
ORDER BY co.amount DESC;

-- 3. Vi???t h??m (kh??ng c?? parameter) tr??? v??? t??n h??ng s???n xu???t ???? b??n ???????c nhi???u 
-- oto nh???t trong n??m nay.

select * from car_order;

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
create function f_lay_ten_hang_ban_nhieu_nhat()
	returns enum('HONDA','TOYOTA','NISSAN')
    begin
		declare ten_hang enum('HONDA','TOYOTA','NISSAN');
		select c.maker into ten_hang
        from car_order co left join car c on co.CarID = c.CarID
        group by c.maker having sum(co.amount) = (
										select max(sl_xe_ban_ra)
                                        from ( select sum(co.amount) as sl_xe_ban_ra
                                        from car_order co left join car c on co.CarID = c.CarID
                                        group by c.maker
										) as tinh_tong_sl_xe );
		return ten_hang;
    end $$
DELIMITER ;

select f_lay_ten_hang_ban_nhieu_nhat();


-- 4. Vi???t 1 th??? t???c (kh??ng c?? parameter) ????? x??a c??c ????n h??ng ???? b??? h???y c???a 
-- nh???ng n??m tr?????c. In ra s??? l?????ng b???n ghi ???? b??? x??a.
DELIMITER $$
create procedure s_delete_order_last_years (out deleted_records int)
	begin
		select count(OrderID) from car_order where OrderDate < DATE_SUB(CURDATE(), interval 1 year) and status = '2';
        delete from car_order where OrderDate < DATE_SUB(CURDATE(), interval 1 year) and Status = '2';
    end $$
DELIMITER ;

call s_delete_order_last_years;

-- 5. Vi???t 1 th??? t???c (c?? CustomerID parameter) ????? in ra th??ng tin c???a c??c ????n 
-- h??ng ???? ?????t h??ng bao g???m: t??n c???a kh??ch h??ng, m?? ????n h??ng, s??? l?????ng oto 
-- v?? t??n h??ng s???n xu???t.

DELIMITER $$
create procedure s_in_thong_tin_order()
	begin
			select cu.`name`, co.OrderID, co.amount, ca.Maker
            from car_order co 
            join car ca on co.CarID = ca.CarID
            join customer cu ON co.CustomerID = cu.CustomerID;
    end $$
DELIMITER ;

-- 6. Vi???t trigger ????? tr??nh tr?????ng h???p ng?????i d???ng nh???p th??ng tin kh??ng h???p l??? 
-- v??o database (DeliveryDate < OrderDate + 15).

DELIMITER $$
create trigger trigger_check_thong_tin 
before insert on car_order
for each row  
	begin
		if NEW.DeliveryDate < date_add(NEW.OrderDate(), interval 15 day) then signal sqlstate '12345' set message_text = 'Ngay giao hang khong duoc vuot qua 15 ngay';
        end if;
    end $$
DELIMITER ;

