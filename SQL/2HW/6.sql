select substring(email from position ('@' in email) + 1) as more_emails
from users
where gender = 'Male'
group by more_emails
order by count(1) desc
limit 3