--CREATE DATABASE BonusPointExchangePlatform

USE BonusPointExchangePlatform

/*銀行帳戶*/
CREATE TABLE Bank(
id int primary key identity(1,1),
name nvarchar(30) not null,
bank_code int not null,
account_no int not null unique,
amount int not null,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*員工*/
CREATE TABLE Employee(
id int primary key identity(1,1),
name nvarchar(30) not null,
employee_no int not null unique,
arrived_at datetime not null,
phone varchar(10) not null,
email varchar(50) not null unique,
image varbinary(max),
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*站內訊息*/
CREATE TABLE Message(
id int primary key identity(1,1),
title nvarchar(50),
content nvarchar(200),
employee_id int,
foreign key (employee_id) references Employee(id) on delete set null,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*問答*/
CREATE TABLE Quest(
id int primary key identity(1,1),
title nvarchar(50),
content nvarchar(200),
employee_id int,
foreign key (employee_id) references Employee(id) on delete set null,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*活動*/
CREATE TABLE Campaign(
id int primary key identity(1,1),
title nvarchar(50),
content nvarchar(200),
max_total int,
join_count int,
begin_at datetime not null,
end_at datetime not null,
image varbinary(max),
button_switch bit not null,
employee_id int,
foreign key (employee_id) references Employee(id) on delete set null,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*信用卡*/
CREATE TABLE Credit_Card(
id int primary key identity(1,1),
name nvarchar(30) not null,
card_no bigint not null unique,
bank_id int,
foreign key (bank_id) references Bank(id) on delete cascade,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*商品*/
CREATE TABLE Product(
id int primary key identity(1,1),
product_name nvarchar(50) not null,
product_content nvarchar(100),
product_type nvarchar(20) not null,
price int not null,
best_seller int not null,
quantity int not null,
button_switch bit not null,
image varbinary(max),
employee_id int,
foreign key (employee_id) references Employee(id) on delete set null,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*會員*/
CREATE TABLE Member(
id int primary key identity(1,1),
name nvarchar(30) not null,
birth date not null,
phone varchar(10) not null,
email varchar(50) not null unique,
image varbinary(max),
bank_id int,
foreign key (bank_id) references Bank(id) on delete set null,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*帳密*/
CREATE TABLE Account(
id int primary key identity(1,1),
account varchar(30) unique,
password varchar(20),
account_type int,
check_code varchar(10),
member_id int,
employee_id int,
foreign key (member_id) references Member(id) on delete cascade,
foreign key (employee_id) references Employee(id) on delete cascade,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*遊戲任務*/
CREATE TABLE Game(
id int primary key identity(1,1),
game_type nvarchar(10) not null,
check_status bit not null,
game_score int ,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*訂單*/
CREATE TABLE Orders(
id int primary key identity(1,1),
--order_token uniqueidentifier default newid() not null,
order_token varchar(40),
order_status nvarchar(10) not null,
sub_total int not null,
member_id int,
foreign key (member_id) references Member(id) on delete set null,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*訂單明細*/
CREATE TABLE Order_Detail(
id int primary key identity(1,1),
product_name nvarchar(50) not null,
product_content nvarchar(100),
quantity int not null,
total int not null,
orders_id int,
foreign key (orders_id) references Orders(id) on delete cascade,
create_at datetime not null default getDate(),
update_at datetime not null default getDate()
);
GO

/*錢包明細*/
CREATE TABLE Wallet(
id int primary key identity(1,1),
source_type nvarchar(10) not null,
wallet_amount int not null,
bonus_point int not null,
credit_card_amount int not null,
member_id int,
bank_id int,
game_id int,
foreign key (member_id) references Member(id) on delete set null,
foreign key (bank_id) references Bank(id) on delete set null,
foreign key (game_id) references Game(id) on delete set null,
create_at datetime not null default getDate()
);
GO

/*支付*/
CREATE TABLE Payment(
id int primary key identity(1,1),
payment nvarchar(20) not null,
orders_id int,
wallet_id int,
foreign key (orders_id) references Orders(id) on delete cascade,
foreign key (wallet_id) references Wallet(id) on delete cascade,
create_at datetime not null default getDate()
);
GO

/*會員-活動*/
CREATE TABLE Member_Campaign(
id int primary key identity(1,1),
create_at datetime not null default getDate(),
update_at datetime not null default getDate(),
member_id int,
campaign_id int,
foreign key (member_id) references Member(id) on delete cascade,
foreign key (campaign_id) references Campaign(id) on delete cascade
);
GO

/*會員-遊戲*/
CREATE TABLE Member_Game(
id int primary key identity(1,1),
create_at datetime not null default getDate(),
update_at datetime not null default getDate(),
member_id int,
game_id int,
foreign key (member_id) references Member(id) on delete cascade,
foreign key (game_id) references Game(id) on delete cascade
);
GO


/*新增資料*/
INSERT INTO Bank(name, bank_code, account_no, amount)
VALUES
('台新銀行', 808, 1234567890, 10000),
('台新銀行', 808, 1111111111, 3345678);

INSERT INTO Employee(name, employee_no, arrived_at, phone, email, image)
VALUES
('AAA', 200001, '2022/09/28', '0987654321', 'AAA@gmail.com', null),
('root', 200002, '2022/09/20', '0987654321', 'root@gmail.com', null);

INSERT INTO Message(title, content, employee_id)
VALUES
('你好', '歡迎光臨', 1),
('你好醜', 'THX', 2);

INSERT INTO Quest(title, content, employee_id)
VALUES
('Q1', '今天吃什麼?', 1),
('Q2', '我是誰?', 2);

INSERT INTO Campaign(title, content, max_total, join_count, begin_at, end_at, image, button_switch, employee_id)
VALUES
('活動1', 'ZXC', 50, 20, '2022/08/01', '2022/08/31', null, 1, 1),
('活動2', 'QWERETRYU', 30, 2, '2022/08/01', '2022/08/31', null, 0, 2);

INSERT INTO Credit_Card(name, card_no, bank_id)
VALUES
('白金卡', 4147000012345678, 1),
('玉璽卡', 4147000000000001, 1),
('黑卡', 4147000000000099, 1),
('玉璽卡', 4145000000000011, 2);

INSERT INTO Product(product_name, product_content, product_type, price, best_seller, quantity, button_switch, image, employee_id)
VALUES
('iPhone 14 Pro', '水貨', '電子', 100, 5, 50, 0, null, 1),
('iPhone XR', '十手', '電子', 200, 3, 20, 0, null, 1),
('iPhone 4', '水貨', '電子', 50, 5, 30, 0, null, 2);

INSERT INTO Member(name, birth, phone, email, image, bank_id)
VALUES
('Tom', '2000/01/01', '0212345678', 'Tom@gmail.com', null, 1),
('Jerry', '2010/01/01', '0200010002', 'Jerry@gmail.com', null, 2);

INSERT INTO Account(account, password, account_type, check_code, member_id, employee_id)
VALUES
('Tom', 'Tom123', 1, null, 1, null),
('Jerry', 'Jerry123', 1, 'abc123', 2, null),
('root', 'root', 3, null, null, 2),
('AAA', 'AAA', 2, 'qwe123asd', null, 1);

INSERT INTO Game(game_type, check_status,game_score)
VALUES
('採集魔水晶', 1,100),
('簽到', 1,null),
('採集魔水晶', 1,100);

INSERT INTO Orders(order_token,order_status, sub_total, member_id)
VALUES
('09921a2c-4ae4-4455-b2c8-ee3e07a80b64', '訂單完成', 150, 1),
('cb977111-a899-42c0-bc4a-ef9773164b4d', '訂單完成', 200, 2);

INSERT INTO Order_Detail(product_name, product_content, quantity, total, orders_id)
VALUES
('iPhone 14 Pro', '水貨', 1, 100,1),
('iPhone 4', '水貨', 1, 50, 1),
('iPhone XR', '十手', 1, 200, 2);

INSERT INTO Wallet(source_type, wallet_amount, bonus_point, credit_card_amount, member_id, bank_id, game_id)
VALUES
('兌換', 2000, 50000, 0, 1, 1, null),
('活動獎勵', 0, 2000, 0, 1, null, 1),
('回饋', 0, 3000, 10000, 2, 2, null),
('交易', 0, -200, 0, 2, null, null),
('交易', 0, -100, 0, 1, null, null),
('交易', 50, 0, 0, 1, null, null);

INSERT INTO Payment(payment, orders_id, wallet_id)
VALUES
('紅利點數', 2, 4),
('紅利點數', 1, 5),
('儲值金', 1, 6);

INSERT INTO Member_Campaign(member_id, campaign_id)
VALUES
(1, 1),
(1, 2),
(2, 1);

INSERT INTO Member_Game(member_id, game_id)
VALUES
(1, 2),
(2, 1),
(1, 3);


INSERT INTO Game(game_type, check_status, game_score,create_at,update_at )
VALUES
('簽到', 1,null,'2022-09-08 19:00:00.111','2022-09-08 19:00:00.111'),
('簽到', 1,null,'2022-09-09 19:00:00.111','2022-09-09 19:00:00.111'),
('簽到', 1,null,'2022-09-10 19:00:00.111','2022-09-10 19:00:00.111'),
('簽到', 1,null,'2022-09-11 19:00:00.111','2022-09-11 19:00:00.111');

INSERT INTO Member_Game(create_at,update_at,member_id, game_id)
VALUES
('2022-09-08 19:00:00.111','2022-09-08 19:00:00.111',2, 4),
('2022-09-09 19:00:00.111','2022-09-09 19:00:00.111',2, 5),
('2022-09-10 19:00:00.111','2022-09-10 19:00:00.111',2, 6),
('2022-09-11 19:00:00.111','2022-09-11 19:00:00.111',2, 7);

/*查詢全表*/
select * from Bank
select * from Employee
select * from Message
select * from Quest
select * from Campaign
select * from Credit_Card
select * from Product
select * from Member
select * from Account
select * from Game
select * from Orders
select * from Order_Detail
select * from Wallet
select * from Payment

update Account set member_id=2 where id=2
select * from Member_Campaign
select * from Member_Game

update Member set bank_id = null where id=2;

delete from Product where id = 1006;

DBCC CHECKIDENT('Product', RESEED,3 );

select * from Game
select * from Member_Game
select * from Member
select * from Wallet

select * from Product
select * from Employee

select * from Product
select * from Orders
select * from Order_Detail

select * from Wallet
select * from Payment

select * from Orders
select * from Order_Detail

select *, CONVERT (nvarchar,create_at,100) from Product where product_type='電子' order by id; 


select * from Account where account = 'Jerry' and password = 'Jerry123'

select * from Wallet where member_id= 1 and source_type!='回饋'; 

update Orders set order_status = '訂單完成' where id=3;

delete from Game where id >7

update Account set account_type = 1 where id = 2


select top 1.id from game where game_type='簽到' and update_at >'2022/11/02'
order by update_at desc

select * from Member where convert(nvarchar,birth,23)= '2000-01-01' and id= 1

select * from Member where birth like '%-01-01%';

update Member set birth='2000-11-03' where id = 1

select * from Member where convert(nvarchar,birth,23) like '%-01-01%' and id= 1



