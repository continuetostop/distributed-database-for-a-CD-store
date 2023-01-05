create table stock(
  stock_id number,
  stock_available number,
  stock_capacity number,
  PRIMARY KEY(stock_id)
);

create table cd(
  cd_id number,
  cd_description varchar2(255),
  PRIMARY KEY(cd_id)
);

create table customer (
  cust_id number,
  cust_score number,
  PRIMARY KEY(cust_id)
);

----
CREATE DATABASE LINK DB_M1 CONNECT TO C##M1 IDENTIFIED BY a123
USING 'tai';

CREATE DATABASE LINK DB_M2 CONNECT TO C##M2 IDENTIFIED BY a123
USING 'tien';


create
or replace procedure create_brand_store(
  brand_store_id number,
  brand_store_name varchar2,
  brand_store_district varchar2,
  brand_store_city varchar2,
  brand_store_hotline varchar2,
  brand_store_status char
) as begin if(brand_store_district = 'Ho Chi Minh') then
insert into
  c ##M1.brand_store@DB_M1 values (null,brand_store_name,brand_store_district,brand_store_city,brand_store_hotline,null);
  else if(brand_store_district = 'Ha Noi') then
insert into
  c ##M2.brand_store@DB_M2 values (null,brand_store_name,brand_store_district,brand_store_city,brand_store_hotline,null);
  else if(brand_store_district = 'Da Nang') then
insert into
  c ##M3.brand_store@DB_M3 values (null,brand_store_name,brand_store_district,brand_store_city,brand_store_hotline,null);
  else dbms_output.put_line('Do not have store at ' || brand_store_city);

end if;

end if;

end if;

end;

create
or replace procedure update_import_cd(
  import_cd_id number,
  cd_id number,
  quatity number
) as begin if(
  import_cd_id > 0
  and import_cd_id < 10000
) then
update
  m1.import_detail_cd @DB_M1
set
  quatity = quatity;

ELSIF(import_cd_id < 10001) then
update
  m2.import_detail_cd @DB_M2
set
  quatity = quatity;

ELSIF(import_cd_id < 20001) then
update
  m3.import_detail_cd @DB_M3
set
  quatity = quatity;

else dbms_output.put_line('import cd id in range [1..30000]');

end if;

end;

create
or replace procedure update_orders_details(
  order_id number,
  stock_id number,
  cd_id number,
  quatity number,
) as begin if(
  order_id > 0
  and order_id < 100000
) then
update
  m1.orders_details @DB_M1
set
  quatity = quatity
where
  order_id = order_id
  and cd_id = cd_id;

elseif(order_id < 100001) then
update
  m2.orders_details @DB_M2
set
  quatity = quatity
where
  order_id = order_id
  and cd_id = cd_id;

elseif(order_id < 200001) then
update
  m3.orders_details @DB_M3
set
  quatity = quatity
where
  order_id = order_id
  and cd_id = cd_id;

else dbms_output.put_line('import cd id in range [1..300000]');

end if;

end;

UPDATE
  c ##m1.CD@DB_M1
SET
  cd_price = 1000
WHERE
  CD_ID = 1;

SELECT
  *
FROM
  c ##m1.CD@DB_M1