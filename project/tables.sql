create database project4;
create table customer(
    customer_id serial primary key,
    customer_fullname varchar(30) not null,
    address varchar(30) not null,
    city varchar(30) not null,
    street varchar(30) not null,
    phone int not null unique ,
    gender varchar(1) not null check ( gender = 'M' OR gender = 'F' ),
    annual_income int not null check ( annual_income > 0 )
);
create table company_buyer(
    customer_id int references customer(customer_id),
    BIN int not null
);
create table ind_buyer(
    customer_id int references customer(customer_id),
    gender varchar(1) not null check ( gender = 'M' OR gender = 'F' ),
    annual_income int not null check ( annual_income > 0 )
);
create table buy(
    BIN int references company_buyer(Bin),
    gender int references ind_buyer(gender),
    date date not null,
    primary key (BIn,gender)



);
create table sales(
    VIN serial primary key,
    customer_id varchar(30) not null,
    dealer_id varchar(30) not null,
    price int not null check(price > 0),
    date varchar(30) not null
);
create table dealer(
    dealer_id serial primary key,
    dealer_name varchar(30) not null,
    dealer_location varchar(30) not null
);
create table sale(
    customer_id int references customer(customer_id),
    VIN int references sales(VIN),
    dealer_id int references dealer(dealer_id),
    primary key(customer_id,VIN, dealer_id)
);
create table inventory(
    inventory_id serial primary key,
    inventory_name varchar(30) not null unique ,
    inventory_location varchar(30) not null,
    dealer_id varchar(30) not null
);
create table access(
    dealer_id int references dealer(dealer_id),
    inventory_id int references inventory(inventory_id),
    primary key (dealer_id, inventory_id)
);
create table vehicles(
    VIN serial primary key,
    option_id varchar(30) not null,
    customer_id varchar(30) not null,
    manufacture_id varchar(30) not null,
    inventory_id varchar(30) not null
);
create table owns(
    customer_id int references customer(customer_id),
    VIN int references vehicles(VIN),
    primary key(customer_id, VIN)
);
create table Options(
    option_id serial primary key,
    color varchar(30) not null,
    engine varchar(30) not null,
    transmission varchar(30) not null
);
create table option(
    VIN int references vehicles(VIN),
    option_id int references Options(option_id)
);
create table Models(
    model_id serial primary key,
    model_fullname varchar(30) not null,
    characteristics text
);
create table model(
    option_id int references Options(option_id),
    model_id int references Models(model_id),
    primary key (option_id, model_id)
);
create table Wagon(
    model_id int references Models(model_id),
    big_trunk varchar not null
);
drop table Wagon;
create table Sedan(
    model_id int references Models(model_id),
    luggage_compartment varchar not null
);

create table Truck(
    model_id int references Models(model_id),
    open_truck varchar not null
);
create table Brands(
    brand_id serial primary key,
    brand_fullname varchar(30) not null,
    ratings int not null check ( ratings > 0 )
);
create table brands(
    model_id int references Models(model_id),
    brand_id int references Brands(brand_id),
    primary key (model_id, brand_id)
);
create table Car_company(
    company_id serial primary key,
    company_fullname varchar(30) not null,
    type varchar not null
);
create table company(
    model_id int references Models(model_id),
    company_id int references Car_company(company_id),
    primary key (model_id, company_id)
);
create table Suppliers(
    suppliers_id serial primary key,
    organization_name varchar(30) not null,
    detail varchar
);
create table Manufactures(
    VIN serial primary key,
    manufacture_name varchar not null,
    manufacture_location varchar not null
);

create table supplier(
    supplier_id int references Suppliers(suppliers_id),
    model_id int references Models(model_id),
    VIN int references Manufactures(VIN),
    primary key (supplier_id, model_id, VIN)
);
create table Produces(
    date date not null
);
create table produce(
    VIN int references Manufactures(VIN),
    date int references Produces(date),
    primary key (VIN,date)
);

--------------
------------
-------------
-------------
--------------
------------
------------
---------------
------------
--------------
--
--
--
--
---
---
--
--
--
--
--
---
insert into customer(customer_fullname, address, city, street, phone,gender, annual_income) values ('Anna','Tashenova 6', 'Almaty', 'Tole-Bi', '12345','F' ,'12k$');
insert into customer(customer_fullname, address, city, street, phone, gender, annual_income) values ('Elena', 'Tashenova 6' , 'Almaty', 'Tole-Bi', '12346', 'M' ,'92k$');
insert into customer(customer_fullname, address, city, street, phone, gender, annual_income) values ('Caroline', 'Tashenova 6' , 'Almaty', 'Abay', '32533', 'M' ,'60k$');
insert into customer(customer_fullname, address, city, street, phone, gender, annual_income) values ('Rebecca', 'Tashenova 6' , 'Shymkent', 'Konaeva', '32434','M' , '90kk$');
insert into customer(customer_fullname, address, city, street, phone, gender, annual_income) values ('Jenna', 'Tashenova 6' , 'Semei', 'Astana', '24131', 'M' ,'126589$');
insert into customer(customer_fullname, address, city, street, phone, gender, annual_income) values ('Bob', 'Tashenova 6' , 'Pavlodar', 'Lenin', '34567', 'F' ,'12million$');
insert into customer(customer_fullname, address, city, street, phone, gender, annual_income) values ('Conor', 'Tashenova 6' , 'Kostanai', 'Mametova', '45678', 'M' ,'1billion$');
insert into customer(customer_fullname, address, city, street, phone, gender, annual_income) values ('Joe', 'Tashenova 6' , 'Aktobe', 'Ryskulova', '56789', 'M' ,'60k$');
insert into customer(customer_fullname, address, city, street, phone,gender, annual_income) values ('Patric', 'Tashenova 6' , 'Nursultan', 'Tolstogo', '67890', 'F' ,'79k$');
insert into customer(customer_fullname, address, city, street, phone, gender, annual_income) values ('Jane', 'Tashenova 6' , 'Karagandy', 'Djandosova', '09876','M' , '81k$');
insert into customer(customer_fullname, address, city, street, phone, gender, annual_income) values ('Mary', 'Tashenova 6' , 'Moscow', 'Main', '78900', 'M' ,'120k$');


insert into brands(brand_fullname, ratings) values ('Bugatti', ' 100');
insert into models(model_fullname, characteristics) values ('X3', 'convertible'),('X2', 'convertible'),('X4','convertible'),('X5','convertible');
insert into sedan(luggage_compartment) values ('jaguar f'), ('smoke detector');
insert into Truck(open_truck) values ('Cement Truck'),('kazakhs');
insert into Wagon(big_trunk) values ('Jenny Lind Trunks'),('Monitor Trunks');
insert into Suppliers(organization_name, detail) values('Kidala.kz','obmanul pol kazakhstana'),('best of elon','luchyie poka chto');
insert into Manufactures(manufacture_name,manufacture_location) values ('Alliance Inc', 'french'),('Manufacturing Nation','italy');
insert into supplier values (1,2,'4Y1SL65848Z411439'),(3,4,'48123658489411439');
insert into Car_company values ('kazmunaikaz','benzinyi'),('zheruiyk','dizel');
insert into company values (1,2),(5,6);
insert into Produces values(2003),(2006);
insert into produce values('48123658489411432','2003'),('48123658489411439','2006');
insert into vehicles values ('55','44','33','22'),('66','77','88','99');
insert into Options values('red','v6','tt'),('green','v8','dd');
insert into model values  (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10), (11, 11), (12, 12), (13, 13), (14, 14), (15, 15), (16, 16), (17, 17), (18, 18), (19, 19), (20, 20), (21, 21), (22, 22), (23, 23), (24, 24), (25, 25), (26, 26), (27, 27), (28, 28), (29, 1), (30, 1), (31, 2), (32, 3), (33, 4), (34, 5), (35, 6), (36, 7), (37, 8), (38, 9), (39, 10), (40, 11), (41, 12), (42, 13), (43, 14), (44, 15), (45, 16), (46, 17), (47, 18), (48, 19), (49, 20), (50, 21), (51, 22), (52, 23), (53, 24), (54, 25), (55, 26), (56, 27), (57, 28), (58, 1), (59, 1), (60, 2), (61, 3), (62, 4), (63, 5), (64, 6), (65, 7), (66, 8), (67, 9), (68, 10);
insert into owns values (5,'4812365848941'),(6,'48123658489411999');
insert into company_buyer values ('4564983138'),('5665123165');
insert into ind_buyer values ('M','100k+$'),('F','1million$');
insert into Sales values (6,8,9,2003),(9,8,5,1999),(56,88,55,1998);
insert into sale values (5,'4Y1SL65848Z4114',6),(4,'4Y1SL65848Z411',4);
insert into dealer values ('Cityline Auto Sales','Kazakhstan'),('Automobile Crew','italy');
insert into access values ( 1 ,  94 ), ( 2 ,  47 ), ( 3 ,  34 ), ( 4 ,  83 ), ( 5 ,  64 ), ( 6 ,  87 ), ( 7 ,  59 ), ( 8 ,  84 ), ( 9 ,  76 ), ( 10 ,  5 ), ( 11 ,  87 ), ( 12 ,  63 ), ( 13 ,  25 ), ( 14 ,  65 ), ( 15 ,  48 ), ( 16 ,  15 ), ( 17 ,  32 ), ( 18 ,  84 ), ( 19 ,  94 ), ( 20 ,  82 );
insert into inventory values ('steam','astana','8'),('google','almty','9');
insert into buy values (1, 'M', to_date('25-04-2018', 'dd-mm-yyyy')), (2, 'F', to_date('10-01-2021', 'dd-mm-yyyy')), (3,'M', to_date('16-09-2018', 'dd-mm-yyyy')), (4, 'F', to_date('07-02-2019', 'dd-mm-yyyy')), (5, 'M', to_date('28-05-2017', 'dd-mm-yyyy')), (6, 'F', to_date('12-04-2019', 'dd-mm-yyyy'));


------
-----
----
---
----
---
---
---
------
---
----
--
--
--
--4,1


--4,2


--4,3
select sum(models.model_fullname) as s, brands.name from buy
    join sale on buy.BIN = sale.customer_id and buy.date > current_date - interval '1 year'
    join model on sale.customer_id = model.model_id
    join models on model.model_id = models.model_id
    join brands on models.model_id = brands.ratings
    join brands on brands.ratings = brands.brand_id
    group by brands.name order by s desc limit 2;