use affordable;

/*
A few useful queries you can run in sql workbench:
select * from authenticationinformation;
select * from stripeDonor;
select * from stripeRecipient;
select * from grants;
select * from stripeHug;
*/

/**
stripeDonor and stripeRecipient must piggyback off of actual affordable accounts, so we insert some dummies
the auto-increment int ID gets auto generated, don't need to specify
*/
insert into authenticationinformation (username, password, isDonor) values
	("testDonor", "password", 1),
	("testRecipient", "password", 0),
	("testRecipient2", "password", 0),
	("testRecipient3", "password", 0),
	("testRecipient5", "password", 0);

insert into stripeDonor (donorID, stripeID, Balance, pendingBalance) values
	("testDonor", "stripeID1", 10.0, 20.0);

insert into stripeRecipient (recipientID, stripeID, Balance, pendingBalance) values
	("testRecipient", "stripeID2", 25.0, 0.0),
    ("testRecipient2", "stripeID2", 25.0, 0.0),
    ("testRecipient3", "stripeID2", 25.0, 0.0),
    ("testRecipient4", "stripeID2", 25.0, 0.0),
    ("testRecipient5", "stripeID2", 25.0, 0.0);


/**
need a valid grant to make a stripeHUG
again, the auto-increment int ID gets auto generated, don't need to specify
*/
insert into grants (grantName) values
	("grant1"), ("grant2");
/* stripeHUG.HUGID must be valid grant.ID !!!*/
insert into stripehug (HUGID, ownerID, HUGName, HUGDescription, Balance, fundingGoal) values
	(1, "testDonor", "awarded HUG", "An example awarded HUG", 15.0, 15.0),
	(2, "testDonor", "optimistic HUG", "An example unawarded HUG with no funds and huge goal", 0.0, 2000000),
    (3, "testDonor", "matched goal HUG", "An example unawarded HUG with matched balance", 33, 33),
    (4, "testDonor", "exceeded HUG", "An example unawarded HUG with matched balance", 50, 25);

insert into HugApplicants (HUGID, recipientID, isNew, Status) values
	(1, 'testRecipient', 1, 'Pending'),
	(1, 'testRecipient2', 1, 'Pending'),
	(2, 'testRecipient3', 1, 'Pending'),
	(2, 'testRecipient4', 1, 'Pending'),
	(2, 'testRecipient5', 1, 'Pending');

/** Award grant1 to testRecipient */
update stripehug
    set recipientID = "testRecipient"
    where HUGID = 1;
update HugApplicants set Status='Accepted' where recipientID='testRecipient';
update HugApplicants set Status='Rejected' where recipientID='testRecipient2';
