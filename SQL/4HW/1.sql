select city, count(age)
from users
group by city
order by count(age) desc;

select city
, sum(case when age >=0 and age <=20 then 1 else 0 end) as young
, sum(case when age >=21 and age <=49 then 1 else 0 end) as adult
, sum(case when age >=50 then 1 else 0 end) as old
from users
group by city;
