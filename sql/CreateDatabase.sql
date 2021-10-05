DROP DATABASE IF EXISTS Affordable;
CREATE DATABASE IF NOT EXISTS Affordable;
USE Affordable;

DROP TABLE IF EXISTS ConnectedBankAccount;
DROP TABLE IF EXISTS HugApplicants;
DROP TABLE IF EXISTS StripeHUG;
DROP TABLE IF EXISTS Card;
DROP TABLE IF EXISTS BankAccount;
DROP TABLE IF EXISTS Fee;
DROP TABLE IF EXISTS StripeDonor;
DROP TABLE IF EXISTS StripeRecipient;
DROP TABLE IF EXISTS InternalTransactions;
DROP TABLE IF EXISTS ExternalTransactions;

DROP TABLE IF EXISTS emails;
DROP TABLE IF EXISTS ForgotPasswordResetToken;
DROP TABLE IF EXISTS requests;
DROP TABLE IF EXISTS twofactor;
DROP TABLE IF EXISTS activitylog;
DROP TABLE IF EXISTS emailReadReceipt;
DROP TABLE IF EXISTS legalName;
DROP TABLE IF EXISTS sexAndEthnicity;
DROP TABLE IF EXISTS marriageInformation;
DROP TABLE IF EXISTS identificationInformation;
DROP TABLE IF EXISTS phoneNumbers;
DROP TABLE IF EXISTS userAddress;
DROP TABLE IF EXISTS informationProvider;
DROP TABLE IF EXISTS insurance;
DROP TABLE IF EXISTS finances;
DROP TABLE IF EXISTS healthcare;
DROP TABLE IF EXISTS OrgMembers;
DROP TABLE IF EXISTS OrgGrants;
DROP TABLE IF EXISTS Donates;
DROP TABLE IF EXISTS ApplicationInformation;
DROP TABLE IF EXISTS GrantDiagnosis;
DROP TABLE IF EXISTS GrantPrescription;
DROP TABLE IF EXISTS GrantRequiredDocumentation;
DROP TABLE IF EXISTS GrantRequiredMedicalInfo;
DROP TABLE IF EXISTS Grants;
DROP TABLE IF EXISTS EligibilityCriteria;
DROP TABLE IF EXISTS GrantLocations;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS OrgLocations;
DROP TABLE IF EXISTS AccountInfo;
DROP TABLE IF EXISTS Recipient;
DROP TABLE IF EXISTS Donor;
DROP TABLE IF EXISTS Organization;
DROP TABLE IF EXISTS AuthenticationInformation;
DROP TABLE IF EXISTS AdminPrivileges;
DROP TABLE IF EXISTS AuditTrail;
DROP TABLE IF EXISTS UserStripe;
DROP TABLE IF EXISTS HUG;
DROP TABLE IF EXISTS conversations;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS conversation_users;
DROP TABLE IF EXISTS zips;

CREATE TABLE LicenseAgreement(
    `agreementId` INT PRIMARY KEY AUTO_INCREMENT,
    `modifiedBy` INT NOT NULL,
    `agreementText` TEXT,
    `dateModified` TIMESTAMP
);

CREATE TABLE AuthenticationInformation(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Username` VARCHAR(255) NOT NULL UNIQUE,
    `Password` VARCHAR(255),
    `Email` VARCHAR(255),
    `Q1` VARCHAR(255),
    `A1` VARCHAR(255),
    `Q2` VARCHAR(255),
    `A2` VARCHAR(255),
    `Q3` VARCHAR(255),
    `A3` VARCHAR(255),
    `RequiresTwoFactorAuthentication` BOOLEAN,
    `TwoFactorCode` VARCHAR(255),
    `isDonor` BOOLEAN,
    `Deactivated` BOOLEAN
  #  `isAdmin` BOOLEAN,
   # `licenseVersionAcknowledged` INT,
  #  FOREIGN KEY(licenseVersionAcknowledged) REFERENCES LicenseAgreement(agreementId) ON DELETE NO ACTION
);

CREATE TABLE AdminPrivileges(
	`userId` INT NOT NULL PRIMARY KEY,
    `Active` BOOLEAN,
	`AllowRejectAdminRegistration` BOOLEAN,
	`RevokeAdminAccess` BOOLEAN,
	`SetPrivileges` BOOLEAN,
	`ResetAuthInfoNonAdmin` BOOLEAN,
	`ResetAuthInfoAdmin` BOOLEAN,
    `ManagePaymentTransactions` BOOLEAN,
	`MessageUserEmailUser` BOOLEAN,
	`VerifyOrg501c3Status` BOOLEAN,
	`DeactivateUsers` BOOLEAN,
	`CreateRemoveHugs` BOOLEAN,
	`CreateRemoveOrgs` BOOLEAN,
	`EditApplications` BOOLEAN,
	`ReadAuditTrail` BOOLEAN,
    `ModifyLicenseAgreement` BOOLEAN,
    FOREIGN KEY(userId) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);


CREATE TABLE emails(
    `userId` INT NOT NULL,
    `email` VARCHAR(255) NOT NULL PRIMARY KEY,
    `primary_ind` BOOLEAN NOT NULL,
    `verified` BOOLEAN NOT NULL
    #`verificationCode` VARCHAR(50),
    #FOREIGN KEY(userId) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);

CREATE TABLE ForgotPasswordResetToken(
    `userId` INT NOT NULL,
    `secret` VARCHAR(255) NOT NULL,
    `expirationDate` DATETIME NOT NULL,
    PRIMARY KEY(userId, secret),
    FOREIGN KEY(userId) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);

CREATE TABLE legalName(
    `id` INT,
    `firstName` VARCHAR(255),
    `middleName` VARCHAR(255),
    `lastName` VARCHAR(255),
    `suffix` VARCHAR(10),
    `isCurrentLegalName` BOOLEAN,
    PRIMARY KEY(id, isCurrentLegalName),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);
CREATE TABLE sexAndEthnicity(
	`id` INT,
    `biologicalSex` VARCHAR(10),
    `ethnicity` VARCHAR(255),
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);
CREATE TABLE identificationInformation(
	`id` INT,
    `birthdate` DATE,
    `SSN` VARCHAR(9),
    `citizenshipStatus` VARCHAR(25),
    `countryOfBirth` VARCHAR(255),
    `alienNumber` VARCHAR(9),
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);
CREATE TABLE marriageInformation(
	`id` INT,
    `marriageStatus` VARCHAR(25),
    `numberOfChildren` INT,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);
CREATE TABLE phoneNumbers(
	`id` INT,
    `phone` VARCHAR(25),
    `preference` INT,
    `preferredLanguage` VARCHAR(255),
    PRIMARY KEY(id, phone),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);
CREATE TABLE userAddress(
	`id` INT,
    `street` VARCHAR(255),
    `city` VARCHAR(255),
    `state` VARCHAR(20),
    `zipCode` VARCHAR(10),
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);
CREATE TABLE informationProvider(
	`id` INT,
    `informationProvider` VARCHAR(255),
    `relationshipToPatient` VARCHAR(255),
    `placeOfEmployment` VARCHAR(255),
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);
CREATE TABLE insurance(
	`id` INT,
    `hasInsurance` BOOLEAN,
    `primaryInsurance` VARCHAR(255),
    `planType` VARCHAR(255),
    `policyId` VARCHAR(30),
    `policyHolder` VARCHAR(255),
    `insuranceFromEmployer` BOOLEAN,
    `companyName` VARCHAR(255),
    `groupNumberPlanCode` VARCHAR(20),
    `hasDeductiblesOrCoPayments` BOOLEAN,
    `deductibleAmount` VARCHAR(5),
    `copayment` VARCHAR(5),
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);
CREATE TABLE finances(
	`id` INT,
    `employmentStatus` BOOLEAN,
    `currentEmployer` VARCHAR(255),
    `positionTitle` VARCHAR(60),
    `grossAnnualIncome` VARCHAR(10),
    `unemploymentPeriod` VARCHAR(20),
	`receivesFinancialAssistance` BOOLEAN,
    `assistanceExplanation` VARCHAR(255),
    `receivesSocialSecurity` BOOLEAN,
    `numberOfPeopleInHousehold` INT,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);
CREATE TABLE healthcare(
	`id` INT,
    `hasPhysician` BOOLEAN,
    `physicianFirstName` VARCHAR(255),
    `physicianLastName` VARCHAR(255),
    -- this should be changed at some point to be an actual address
    `physicianLocation` VARCHAR(255),
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);
CREATE TABLE requests(
    `Username` VARCHAR(255),
    `NewEmail` VARCHAR(255),
    `OldEmail` VARCHAR(255),
    `RandomString` VARCHAR(255),
    `Timestamp` VARCHAR(255),
    `Secret` VARCHAR(255)

);

CREATE TABLE twofactor(
    `DeviceName` VARCHAR(255),
    `Username` VARCHAR(255),
    `Email` VARCHAR(255),
    `RandomString` VARCHAR(255),
    `Timestamp` VARCHAR(255),
    `Secret` VARCHAR(255)
);


CREATE TABLE activitylog(
    `IP_addr` VARCHAR(255),
    `Username` VARCHAR(255),
    `Last_Act` VARCHAR(255),
    `city` VARCHAR(255),
    `state` VARCHAR(255),
    `Timestamp` VARCHAR(255)
);


CREATE TABLE emailReadReceipt(
    `Username` VARCHAR(255),
    `Email_Id` VARCHAR(255),
    `Email_Description` VARCHAR(255),
    `Has_Been_Read` VARCHAR(255)
);


CREATE TABLE Recipient(
    `userId` INT,
     PRIMARY KEY(userId),
     FOREIGN KEY(userId) REFERENCES AuthenticationInformation(id)
     ON DELETE CASCADE
);

CREATE TABLE Donor(
    `id` INT,
     PRIMARY KEY(id),
     FOREIGN KEY(id) REFERENCES AuthenticationInformation(id)
     ON DELETE CASCADE
);

CREATE TABLE Organization(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255),
    `email` VARCHAR(255),
    `phone` VARCHAR(255),
    `fax` VARCHAR(255),
    `websiteUrl` VARCHAR(2000),
    `mission` VARCHAR(1000),
    `ein` VARCHAR(1000),
    `taxSection` VARCHAR(1000),
    `IRSActivityCode` VARCHAR(1000),
    `provideService` BOOLEAN,
    `addBankingInfo` BOOLEAN,
    `verified` BOOLEAN,
    `apiKey` VARCHAR(255)
);

CREATE TABLE EligibilityCriteria(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `organizationId` INT NOT NULL,
    `emailAddress` VARCHAR(255),
    -- `minimumAge` INT,
    -- `maximumAge` INT,
    -- `sex` VARCHAR(255),
    -- `ethnicity` VARCHAR(255),
    -- `isUsCitizen` BOOLEAN,
    -- `minimumIncome` INT,
    -- `maximumIncome` INT
    FOREIGN KEY(organizationId) REFERENCES Organization(id) ON DELETE CASCADE
);

CREATE TABLE Grants(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `grantName` VARCHAR(255) NOT NULL,
    `grantAmount` DECIMAL(13,2) NOT NULL,
    `startTime` DATETIME NOT NULL,
    `endTime` DATETIME,
    `category` VARCHAR(500),
    `description` VARCHAR(2000) NOT NULL,
    `organizationId` INT,
    `recipientId` INT NOT NULL,
    `eligibilityCriteriaId` INT,
    FOREIGN KEY(recipientId) REFERENCES Recipient(userId) ON DELETE RESTRICT,
    FOREIGN KEY(organizationId) REFERENCES Organization(id) ON DELETE CASCADE,
    FOREIGN KEY(eligibilityCriteriaId) REFERENCES EligibilityCriteria(id) ON DELETE SET NULL
);

CREATE TABLE ApplicationInformation(
    `id`      INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `userId`  INT NOT NULL,
    `grantId` INT NOT NULL,
    CONSTRAINT ONE_APPLICATION_PER_USER UNIQUE (userId, grantId),
    FOREIGN KEY (userId) REFERENCES Recipient (userId),
    FOREIGN KEY (grantId) REFERENCES Grants (id) ON DELETE CASCADE
);

CREATE TABLE OrgMembers(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `organizationId` INT NOT NULL,
    `donorId` INT NOT NULL,
    `isAdmin` BOOLEAN,
    `membershipStartDate` DATE,
    CONSTRAINT MEMBERSHIP UNIQUE (organizationId, donorId),
    FOREIGN KEY(organizationId) REFERENCES Organization(id) ON DELETE CASCADE,
    FOREIGN KEY(donorId) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);

CREATE TABLE OrgGrants(
    `grantId` INT,
    `orgId` INT,
    PRIMARY KEY(grantId, orgId),
    FOREIGN KEY(orgId) REFERENCES Donor(id) ON DELETE CASCADE,
    FOREIGN KEY(grantId) REFERENCES Grants(id)
    ON DELETE CASCADE
);

CREATE TABLE Donates(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `grantId` INT NOT NULL,
    `donateAmount` DECIMAL(13,2) NOT NULL,
    `donorId` INT NOT NULL,
    FOREIGN KEY(donorId) REFERENCES Donor(id) ON DELETE CASCADE,
    FOREIGN KEY(grantId) REFERENCES Grants(id)
    ON DELETE CASCADE
);


CREATE TABLE Services(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `orgId` INT,
    `service` VARCHAR(255),
    `specialtyService` VARCHAR(255),
    FOREIGN KEY(orgId) REFERENCES Organization(id)
    ON DELETE CASCADE
);

CREATE TABLE OrgLocations(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `orgId` INT,
    `locationType` VARCHAR(255),
    `addressLine1` VARCHAR(255),
    `addressLine2` VARCHAR(255),
    `city` VARCHAR(255),
    `state` VARCHAR(255),
    `zip` VARCHAR(255),
    FOREIGN KEY(orgId) REFERENCES Organization(id)
    ON DELETE CASCADE
);

CREATE TABLE AccountInfo(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `accountType` VARCHAR(255),
    `accountNickname` VARCHAR(255),
    `accountName` VARCHAR(255),
    `accountRouting` VARCHAR(255),
    `accountNumber` VARCHAR(255),
    `orgId` INT,
    `userId` INT,
     FOREIGN KEY(userId) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE,
     FOREIGN KEY(orgId) REFERENCES Organization(id) ON DELETE CASCADE
);

CREATE TABLE zips(
  `zip` VARCHAR(10),
  `city` VARCHAR(255),
  `state_id` VARCHAR(255),
  `state_name` VARCHAR(255),
  `county_name` VARCHAR(255)
);


/*

Stripe Tables Start Here

*/

CREATE TABLE InternalTransactions(
	internalTransactionID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	fromID VARCHAR(255) NOT NULL,
	transactionType ENUM('Donor to Hug', 'Hug to Recipient'),
	toID VARCHAR(255) NOT NULL,
	creationTimestamp TIMESTAMP,
	Amount DECIMAL(13, 4)
);

CREATE TABLE ExternalTransactions(
	externalTransactionID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	userID VARCHAR(255) NOT NULL,
	paymentMethodID VARCHAR(255) NOT NULL,
    chargeID VARCHAR(255) NOT NULL,
	transactionType ENUM('Deposit', 'Donor Withdrawal', 'Recipient Withdrawal'),
	Amount DECIMAL(13, 4),
    Status ENUM('Initiated', 'Pending', 'Cleared', 'Failed'),
    creationTimestamp TIMESTAMP NOT NULL,
    clearedTimestamp TIMESTAMP
);



CREATE TABLE StripeDonor(
    donorID INT NOT NULL,
	stripeID VARCHAR(255),
    connectedAccountID VARCHAR(255),
	Balance DECIMAL(13, 4),
	pendingBalance DECIMAL(13, 4),
    acceptedStripeTerms BOOLEAN,
    PRIMARY KEY(donorID),
    FOREIGN KEY(donorID) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);

CREATE TABLE StripeRecipient(
    recipientID INT NOT NULL,
	stripeID VARCHAR(255),
	Balance DECIMAL(13, 4),
	pendingBalance DECIMAL(13, 4),
    acceptedStripeTerms BOOLEAN,
    PRIMARY KEY(recipientID),
    FOREIGN KEY(recipientID) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);

CREATE TABLE StripeHUG(
    HUGID INT NOT NULL AUTO_INCREMENT,
    ownerID VARCHAR(255),
    recipientID INT NOT NULL,
	HUGName VARCHAR(255) UNIQUE,
	HUGDescription VARCHAR(255),
	Balance DECIMAL(13, 4),
    fundingGoal DECIMAL(13, 4),
    PRIMARY KEY(HUGID),
    /*FOREIGN KEY(HUGID) REFERENCES Grants(id),*/
    /*FOREIGN KEY(ownerID) REFERENCES StripeDonor(donorID),*/
    FOREIGN KEY(recipientID) REFERENCES StripeRecipient(recipientID) ON DELETE CASCADE
);

CREATE TABLE Fee(
	feeID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    HUGID INT,
    stripeFee DECIMAL(13, 4),
    managementFee DECIMAL(13, 4),
    Status ENUM('Pending', 'Cleared', 'Failed'),
    FOREIGN KEY(HUGID) REFERENCES StripeHUG(HUGID) ON DELETE CASCADE
);

CREATE TABLE Card(
    cardID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    stripeCardID VARCHAR(255),
	donorID INT NOT NULL,
    card_nickname VARCHAR(255),
    cardType ENUM('Credit', 'Debit'),
    FOREIGN KEY(donorID) REFERENCES StripeDonor(donorID) ON DELETE CASCADE
);

CREATE TABLE ConnectedBankAccount(
    bankAccountID VARCHAR(255) NOT NULL PRIMARY KEY,
    stripeAccountID VARCHAR(255),
	userID INT NOT NULL,
    accountHolder VARCHAR(255) NOT NULL,
    last4 varchar(255) NOT NULL,
    Verified BOOLEAN,
    FOREIGN KEY(userID) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
    -- FOREIGN KEY(stripeAccountID) REFERENCES StripeRecipient(stripeID) ON DELETE CASCADE
);

CREATE TABLE UserProfileInformation (
    id INT NOT NULL,
    firstName VARCHAR(255),
    middleName VARCHAR(255),
    lastName VARCHAR(255),
    suffix VARCHAR(10),
    dateOfBirth DATE,
    streetAddress VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zipCode VARCHAR(10),
    phone VARCHAR(10),
    FOREIGN KEY(id) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);

CREATE TABLE HugApplicants(
    HUGID INT,
    recipientID INT NOT NULL,
    fullName VARCHAR(255),
    story VARCHAR(1000),
    isNew BOOLEAN,
    Status ENUM('Accepted', 'Rejected', 'Pending'),
    covid ENUM('Yes', 'No', 'Maybe'),
    share ENUM('Yes', 'No'),
    monthly_income ENUM('1000','1000-2000','2000-3000','3000-5000','5000'),
    desiredAmount INT,
    fileKey1 VARCHAR(255),
    fileKey2 VARCHAR(255),
    fileKey3 VARCHAR(255),
    FOREIGN KEY(recipientID) REFERENCES StripeRecipient(recipientID) ON DELETE CASCADE,
    FOREIGN KEY(HUGID) REFERENCES StripeHUG(HUGID) ON DELETE CASCADE
);

CREATE TABLE AuditTrail(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    admin VARCHAR(255),
    action VARCHAR(255),
    time TIMESTAMP
);


CREATE TABLE UserStripe(
    stripeCustomerID VARCHAR(255) NOT NULL PRIMARY KEY,
    userID INT NOT NULL UNIQUE,
    epochTime VARCHAR(255),
    FOREIGN KEY(userID) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);



CREATE TABLE BankAccount(
    bankAccountID VARCHAR(255) NOT NULL PRIMARY KEY,
    bank_nickname VARCHAR(255),
    -- NOT NULL for stripeCustomerID, and stripeBankAccountID later
    stripeCustomerID VARCHAR(255),
    stripeBankAccountID VARCHAR(255),
	userID INT NOT NULL,
    accountHolder VARCHAR(255) NOT NULL,
    last4 varchar(255) NOT NULL,
    Verified BOOLEAN,
    epochTime VARCHAR(255),

    FOREIGN KEY(userID) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
    -- FOREIGN KEY(stripeCustomerID) REFERENCES StripeDonor(stripeID) ON DELETE CASCADE
);

CREATE TABLE HUG(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ownerID INT NOT NULL,
    donationGOAL INT NOT NULL,
    isVisible BOOLEAN,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    type ENUM('Monetary','Service'),
    firstLanguage VARCHAR(255),
    numDependents INT,
    isMarried BOOLEAN,
    ethnicity VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    minAge INT,
    maxAge INT,
    sex VARCHAR(255),
    minIncome INT,
    maxIncome INT,
    employed BOOLEAN,
    epochTime VARCHAR(255),

    FOREIGN KEY(ownerID) REFERENCES AuthenticationInformation(id) ON DELETE CASCADE
);

CREATE TABLE Applicants(
    HUGID INT NOT NULL,
    recipientID INT NOT NULL,
    epochTime VARCHAR(255),
    decision ENUM('Approved', 'Denied', 'Pending') NOT NULL,
    FOREIGN KEY(recipientID) REFERENCES StripeRecipient(recipientID) ON DELETE CASCADE,
    FOREIGN KEY(HUGID) REFERENCES HUG(id) ON DELETE CASCADE,
    UNIQUE KEY (HUGID, recipientID)
);

CREATE TABLE conversations(
    `Convo_Id` INT,
    `chat_name` VARCHAR(255)
);

CREATE TABLE conversation_users(
    `Convo_Id` INT,
    `User_Id` INT,
    `is_left` INT DEFAULT 0,
    `last_message_id` INT,
    `left_at` VARCHAR(255)
);

CREATE TABLE messages(
    `Message_Id` INT,
    `Sender_Id` INT,
    `Conversation_Id` INT,
    `timestamp` VARCHAR(255),
    `Message_Type` VARCHAR(255),
    `body` VARCHAR(255),
    `status` ENUM('Sent', 'Read')
);

-- TODO: Deprecate and remove procedures
DELIMITER //
DROP PROCEDURE IF EXISTS GetAuthenticationInformationByUsername //

CREATE PROCEDURE GetAuthenticationInformationByUsername(
    `@username` VARCHAR(255)
)
BEGIN
    SELECT * FROM AuthenticationInformation WHERE Username = `@username`;
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS GetAuthenticationInformationByEmail //

CREATE PROCEDURE GetAuthenticationInformationByEmail(
    `@email` VARCHAR(255)
)
BEGIN
    SELECT * FROM AuthenticationInformation WHERE Email = `@email`;
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS SeleniumMultipleEmailsData //

CREATE PROCEDURE SeleniumMultipleEmailsData()
BEGIN
    INSERT INTO emails(Username, Email, primary_ind) VALUES('affordTest', 'afford.health.test@gmail.com', '1');
    INSERT INTO AuthenticationInformation(ID, Username, Password, Email) VALUES ('123', 'affordTest', 'Affordtest1!', 'afford.health.test@gmail.com');
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS UpdatePasswordByEmail //

CREATE PROCEDURE UpdatePasswordByEmail(
    `@email` VARCHAR(255),
    `@newPassword` VARCHAR(255)
)
BEGIN
    UPDATE AuthenticationInformation
    SET Password = `@newPassword`
    WHERE Email = `@email`;
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS UpdatePasswordByUsername //

CREATE PROCEDURE UpdatePasswordByUsername(
    `@username` VARCHAR(255),
    `@newPassword` VARCHAR(255)
)
BEGIN
    UPDATE AuthenticationInformation
    SET Password = `@newPassword`
    WHERE Username = `@username`;
END //
DELIMITER ;
