
create table city(
    city_id number,
    city_name varchar2(255),
    PRIMARY KEY(city_id)
);

create table brand_store(
    brand_store_id number,
    brand_store_name varchar2(255),
    brand_store_district varchar2(255),
    brand_store_city_id number,
    brand_store_hotline varchar2(15),
    PRIMARY KEY(brand_store_id),
    FOREIGN KEY (brand_store_city_id) REFERENCES city(city_id)
);

create table stock(
    stock_id number,
    stock_city_id number,
    stock_name varchar2(255),
    PRIMARY KEY(stock_id),
    FOREIGN KEY (stock_city_id) REFERENCES city(city_id)
);


create table cd(
    cd_id number,
    cd_title varchar2(255),
    cd_price number,
    PRIMARY KEY(cd_id)
);

create table stock_detail(
    cd_id number,
    stock_id number,
    stock_available number,
    PRIMARY KEY(cd_id,stock_id),
    FOREIGN KEY (stock_id) REFERENCES stock(stock_id),
    FOREIGN KEY (cd_id) REFERENCES cd(cd_id)
);

create table import_cd(
    import_cd_id number,
    stock_id number,
    brand_store_id number,
    createdAt date default sysdate not null,
    PRIMARY KEY(import_cd_id),
    FOREIGN KEY (stock_id) REFERENCES stock(stock_id),
    FOREIGN KEY (brand_store_id) REFERENCES brand_store(brand_store_id)
);

create table import_cd_detail(
    import_cd_id number,
    cd_id number,
    quatity number,
    PRIMARY KEY(import_cd_id,cd_id),
    FOREIGN KEY (import_cd_id) REFERENCES import_cd(import_cd_id) ON DELETE CASCADE,
    FOREIGN KEY (cd_id) REFERENCES cd(cd_id)
);

create table customer (
    cust_id number,
    cust_city_id number,
    cust_name varchar2(255),
    cust_number_phone varchar2(15),
    PRIMARY KEY(cust_id),
    FOREIGN KEY (cust_city_id) REFERENCES city(city_id)
);

create table orders(
    order_id number,
    brand_store_id number,
    stock_id number,
    cust_id number,
    total number,
    order_date date default sysdate not null,
    PRIMARY KEY(order_id),
    FOREIGN KEY (brand_store_id) REFERENCES brand_store(brand_store_id),
    FOREIGN KEY (stock_id) REFERENCES stock(stock_id),
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);

create table orders_details(
    order_id number,
    cd_id number,
    quatity number,
    price number,
    PRIMARY KEY(order_id,cd_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (cd_id) REFERENCES cd(cd_id)
);


insert into city values (1,'Ha Noi');
insert into city values (2,'Ho Chi Minh');
insert into city values (3,'Da Nang');

insert into brand_store values(1,'branch Ha Noi','cau giay',1,'0962xxxx');
insert into brand_store values(2,'branch Ho Chi Minh','Thu Duc',2,'0962xxxx');
insert into brand_store values(3,'branch Da Nang','Thu Duc',3,'0962xxxx');

create table brand_store(
    brand_store_id number,
    brand_store_name varchar2(255),
    brand_store_district varchar2(255),
    brand_store_city_id number,
    brand_store_hotline varchar2(15),
    PRIMARY KEY(brand_store_id),
    FOREIGN KEY (brand_store_city_id) REFERENCES city(city_id)
);