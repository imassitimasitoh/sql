CREATE TABLE email_list (
    ID INT,
    email TEXT
);

INSERT INTO email_list (ID, email) VALUES
(1, 'abc@gmail.com'),
(2, 'def@gmail.com'),
(3, 'abc@yahoo.com'),
(4, 'abc@gmail.com'),
(5, 'def@gmail.com'),
(6, 'def@gmail.com'),
(7, 'abc@bing.com');

SELECT DISTINCT email
FROM email_list
GROUP BY email
HAVING COUNT(email) > 1;

