CREATE DATABASE bank_analytics;

use bank_analytics;

create table dim_customer(
cust_id int primary key,
age int NOT NULL,
gender char(1) NOT NULL,
city varchar(30) ,
income_band varchar(30) NOT NULL,
is_premium char(1) NOT NULL,
join_date date,
constraint cu_ag_ch check(age>18),
constraint cu_ge_ch check(gender in ('M','F')),
constraint cu_pre_ch check(is_premium in ('Y','N'))
);

SELECT * FROM DIM_CUSTOMER;
insert into dim_customer values (101,28,'M','Chennai','High','Y','2025-05-13');
insert into dim_customer values (102,26,'F','Mumbai','Very High','Y','2025-09-16');
insert into dim_customer values (103,20,'M','Bangalore','Medium','N','2024-07-27');


create table dim_branch(
branch_id int primary key,
branch_name varchar(30) not null,
city varchar(30) not null,
region varchar(30) not null,
branch_type varchar(30) not null,
constraint br_bt_ch check(branch_type in ('Metro','Urban','Semi-Urban','Rural'))
);

SELECT * FROM DIM_branch;
insert into dim_branch values(1,'Chennai Central','Chennai','South','Metro');

create table dim_product(
product_id int primary key,
product_name varchar(30) not null,
product_type varchar(30) not null,
base_interest_rate decimal(5,2) not null,
max_tenure_years int not null,
constraint pr_pt_ch check(product_type in ('Secured','Unsecured')),
constraint pr_bi_ch check(base_interest_rate > 0),
constraint pr_mt_ch check(max_tenure_years > 0)
);

select * from dim_product;
insert into dim_product values(1,'Home Loan','Secured',8.50,20);

select * from fact_loans;

CREATE TABLE fact_loans(
loan_id INT PRIMARY KEY,
cust_id INT,
branch_id INT,
product_id INT,
loan_amount INT NOT NULL,
interest_rate DECIMAL(5,2) NOT NULL,
tenure_years INT NOT NULL,
loan_status VARCHAR(30),
CONSTRAINT fl_la_ch CHECK(loan_amount > 0),
CONSTRAINT fl_ir_ch CHECK(interest_rate > 0),
CONSTRAINT fl_ty_ch CHECK(tenure_years > 0),
CONSTRAINT fl_ls_ch CHECK(loan_status IN ('Active','Closed','Default')),
FOREIGN KEY (cust_id) REFERENCES dim_customer(cust_id),
FOREIGN KEY (branch_id) REFERENCES dim_branch(branch_id),
FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

ALTER TABLE fact_loans
ADD date_id INT;

alter table fact_loans add constraint fk_date foreign key(date_id) references dim_date(date_id);

select * from fact_loans;
insert into fact_loans values (1,101,1,1,500000,8.50,10,'Active',1);

create table dim_date(
date_id int primary key,
full_date date not null,
month int not null,
month_name  varchar(30) not null,
quarter  int  not null,
year int not null,
constraint dd_mn_ch check(month between 1 and 12),
constraint dd_qtr_ch check(quarter between 1 and 4)
);

select * from dim_date;
insert into dim_date values(1,'2025-09-16',9,'Sep',3,2025);





















