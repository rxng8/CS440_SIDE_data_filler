/* Modify to whatever database you are using */
USE Affordable;

-- Delete recipient, donor, and admin
DELETE FROM AuthenticationInformation WHERE username = 'test_recipient';
DELETE FROM AuthenticationInformation WHERE username = 'test_donor';
DELETE FROM AuthenticationInformation WHERE username = 'test_admin';

-- DELETE FROM AuthenticationInformation WHERE username = 'test1'; 

SELECT username FROM AuthenticationInformation;
