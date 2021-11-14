--1 equation
--a) binary large object -- object is a large collection of uninterpreted binary data
--b) character large object -- object is a large collection of character data 
--2 equation

select * from accounts;
select * from customers;
select * from transactions;
create role accountant;
create role administrator;
create role support;
grant select on accounts to accountant;
grant all privileges on accounts, customers, transactions to administrator;
grant select, insert, update on accounts, customers, transactions to support;
create user Martin;
create user Jack;
create user Kevin;
grant accountant to Kevin;
grant administrator to Jack;
grant support to Martin;
grant accountant, support to Jack with admin option;
revoke admin option for accountant, support from Jack;


--3 equation
select * from accounts;
select * from customers;
select * from transactions;
alter table accounts alter column currency set not null;
alter table customers alter column name set not null;
alter table transactions alter column date set not null;


--4 equation
create type currency_code as (code varchar(3));
alter table accounts alter column currency type currency_code using currency::varchar(3)::currency_code;

--5 equation
create unique index cust_curr_index on accounts (customer_id, currency);
create index curr_bal_index on accounts (currency, balance);
--6 equation
create or replace procedure money_transaction2(sender varchar,
                                               receiver varchar, amount double precision)
    language plpgsql
as
$$
declare
    transaction_id int;
    after_balance double precision;
    acc_limit double precision;
begin
    select id+1 into transaction_id from transactions order by id desc limit 1;
    select "limit" into acc_limit from accounts where account_id = sender;
    insert into transactions
    values (transaction_id, now(), sender, receiver, amount, 'init');
    update accounts
    set balance = balance + amount
    where account_id = receiver;
    update accounts
    set balance = balance - amount
    where account_id = sender;

    select balance into after_balance from accounts where account_id = sender;
    if(after_balance < acc_limit) then
        rollback;
        insert into transactions values (transaction_id, now(), sender, receiver, amount, 'rollback');
    else
        update transactions set status = 'committed' where id = transaction_id;
        commit;
    end if;
end
$$;

begin;
update accounts
set balance = balance + 300
where account_id = 'RS88012';
select *
from accounts;
rollback;

select *
from accounts;
select *
from transactions;

call money_transaction2('RS88012', 'NT10204', 300);
call money_transaction2('NT10204', 'RS88012', 300);

call money_transaction2('AB10203', 'NK90123', 300);

begin;
delete from transactions
where amount = 300 and status = 'init';
delete from transactions
where id = 6;
select * from transactions;
commit;