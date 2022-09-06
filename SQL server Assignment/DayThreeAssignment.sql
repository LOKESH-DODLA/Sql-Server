-- Assignment 3
 
-- 1) 1.	Re-create the Customers and Orders tables, enhancing their definition with all primary and foreign keys constraints.
sp_helpconstraint town;

select * from orders;
select * from town;

insert into town values('ord01', 'DOM', 'JIM', 'Address for sale', 'jersy', '74357423', '47036406034');

alter table town add constraint CI_pk primary key(customer_id);

alter table orders add constraint O_pk primary key(order_id);

alter table orders add constraint CI_fk foreign key(customer_id) references town(customer_id);

-- 2.	Using the ALTER TABLE statement, create an integrity constraint that limits the possible values of the quantity column in the Orders table to values between 1 and 30.

alter table orders add constraint o_integrity not null order_id;


--- 3.	Display all integrity constraints for the Orders table.

sp_helpconstraint orders;

--  4.	Delete the primary key of the Customers table. Why isn’t that working?

alter table town drop constraint CI_pk;


--  5.	Delete the integrity constraint defined in Step-2.

