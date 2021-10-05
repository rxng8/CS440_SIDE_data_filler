use affordable;

/*
    donor asdf1 10 200

*/
insert into authenticationinformation (username, password, email, RequiresTwoFactorAuthentication, TwoFactorCode, isDonor)
VALUES
('donor', '$2b$10$TrweBLAQEfIFe62Y/KL7B.nxK5JB8sfTj7bT5F1/A646rM0LYbMSK', 'donor@gmail.com', '0', 'GFEGWLZ3NZBTOVKHGRRFI3R7PBUEIRCK', '1');

insert into authenticationinformation (username, password, email, isDonor) values 
	("testDonor", "password", "donor@donor.website", 1),
	("testRecipient", "password", "recipient@donor.website", 0),
	("testRecipient2", "password", "recipient@donor.website", 0),
	("testRecipient3", "password", "recipient@donor.website", 0),
	("testRecipient4", "password", "recipient@donor.website", 0),
	("testRecipient5", "password", "recipient@donor.website", 0);

insert into stripeDonor (donorID, stripeID, Balance, pendingBalance) values 
	("donor", "stripeID1", 10.0, 200.0);

insert into stripeRecipient (recipientID, stripeID, Balance, pendingBalance) values 
	("testRecipient", "stripeID2", 25.0, 0.0),
    ("testRecipient2", "stripeID2", 25.0, 0.0),
    ("testRecipient3", "stripeID2", 25.0, 0.0),
    ("testRecipient4", "stripeID2", 25.0, 0.0),
    ("testRecipient5", "stripeID2", 25.0, 0.0);

insert into stripeHug (ownerID, HUGName, HUGDescription,Balance, fundingGoal) values 
	("donor", "Covid-19", "For those who decieded not to stay indoors", 15.0, 150.0), 
	("donor", "Save the Cats","Cats are cute and need our love", 21, 20),
    ("donor", "Giving Affordable Love","We wish to do great in this CDR", 0, 100),
    ("donor", "Purtilo Fund","Funding the research done by Dr. Purtilo", 2100, 2000)
    ;

insert into HugApplicants (HUGID, recipientID, isNew, Status) values
	(2, 'testRecipient3', 1, 'Pending'),
	(2, 'testRecipient4', 1, 'Pending'),
	(2, 'testRecipient5', 1, 'Pending');

