SELECT substring(email FROM position ('@' IN email) + 1) AS more_emails
FROM users
WHERE gender = 'Male'
GROUP BY more_emails
ORDER BY count(1) DESC
LIMIT 3