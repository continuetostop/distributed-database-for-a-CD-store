

--cập nhật tổng đơn hàng sau khi thêm sản phẩm vào đơn hàng
CREATE
OR REPLACE TRIGGER orders_details_after_delete
AFTER
DELETE
    ON orders_details FOR EACH ROW
    DECLARE curr_stock_id number;

BEGIN

select stock_id into curr_stock_id 
   from orders 
   where order_id=:old.order_id;

-- cập nhật tổng tiền của đơn hàng
UPDATE
    orders
SET
    total = total - :old.quatity * :old.price
WHERE
    orders.order_id = :old.order_id;


--cập nhật số lượng cd có trong kho
UPDATE
    stock_detail
SET
    stock_detail.STOCK_AVAILABLE = stock_detail.STOCK_AVAILABLE + :old.quatity
WHERE
    stock_detail.cd_id = :old.cd_id and stock_detail.stock_id=curr_stock_id;

--cập nhật số lượng hàng có bên trong kho
UPDATE
    c##admin.stock@DB_admin
SET
    STOCK_AVAILABLE = STOCK_AVAILABLE + :old.quatity
    where stock_id=curr_stock_id;
END;


--cập nhật số lượng cd có trong kho sau khi thêm chi tiết sản phẩm

create or replace trigger import_cd_detail_after_delete
after delete on import_cd_detail 
for each ROW
DECLARE
    cd_exist_stock int;
    curr_stock_id int;
    curr_stock_available int;
    curr_stock_capacity int;
begin 
   select stock_id into curr_stock_id from import_cd where import_cd_id=:old.import_cd_id;
   update stock_detail
   set stock_available=stock_available-:old.quatity
   where stock_id=curr_stock_id and cd_id=:old.cd_id;
   
   update C##admin.stock@db_admin 
   set stock_available=stock_available-:old.quatity
   where stock_id=curr_stock_id;
end;



