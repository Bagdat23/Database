--a
select * from dealer d cross join client c;
--b
select d.id, d.name, c.id, c.name, s.id, city, priority, date, amount
from dealer d
full join client c on d.id = c.dealer_id
full join sell s on d.id = s.dealer_id and c.id = s.client_id;
--c
select d.name, c.name, d.location, c.city from dealer d
inner join client c on d.location = c.city;
--d
select s.id, amount, c.name, city
from sell as s
inner join client c on c.id = s.client_id
where 100 <= amount and amount <= 500;
--e
select d.name, count(d.id)
from dealer d
full join client c on d.id = c.dealer_id
group by d.name
having count(d.id) >= 0;
--f
select d.name, c.id, c.name, city, charge
from dealer d
full join client c on d.id = c.dealer_id;
--g
select c.id, c.name, c.city, d.name,charge
from client c
full join dealer d on d.id = c.dealer_id
where charge >= 0.12;
--h
select c.name, city, s.id, s.amount, d.name, charge
from client c
full join sell s on c.id = s.client_id
full join dealer d on d.id = c.dealer_id;
--i
select c.name, c.priority, d.name, s.id, s.amount                           
from dealer d
left join client c on c.dealer_id = d.id
left join sell s on c.id = s.client_id
where priority is not null and s.amount > 2000;
--(((2)))
--a
create view a_each_day as select date, count(c.id), avg(amount), sum(amount)
from sell
left join client c on c.id = sell.client_id
group by date;
--b
create view b_five_top_days as select date, amount
from sell
order by amount desc limit 5;
--c
create view c_each_dealer as select d.name, count(s.id),avg(amount),sum(amount)
from dealer d
left join sell s on d.id = s.dealer_id
group by d.name;
--d
create view d_location_charge as select d.location, sum(amount), sum(amount)*(charge)
from dealer d
left join sell s on d.id = s.dealer_id
group by d.location,charge;
--e
create view e_each_dealer_location as select d.location, count(s.id), sum(amount)
from dealer d
left join sell s on d.id = s.dealer_id
group by d.location, charge;
--f
create view f_client_city_sell as select c.city, count(s.id), sum(amount), avg(amount)
from client c
left join sell s on c.id = s.client_id
group by c.city;
--g
create view g_city_expense as select c.city, count(s.id), sum(amount)
from client c
join sell s on c.id  = s.client_id
join dealer d on s.dealer_id = d.id and c.city = d.location
group by city;