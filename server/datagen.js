/** Datagen file */

import env from 'dotenv';
env.config();
import * as mysql from 'mysql';
import { createConnection, createPool } from 'mysql';
import fs, { fchownSync } from 'fs';

import { getMonthFromString, _calculateAge } from './utils.js';

const GENERATED_DATA_FOLDER = "./generated";
if (!fs.existsSync(GENERATED_DATA_FOLDER)) {
  fs.mkdirSync(GENERATED_DATA_FOLDER);
}

let test_user_id = Math.floor(Math.random() * 6);

var connection = mysql.createPool({
  connectionLimit: 100,
  host     : process.env.AFFORDABLE_DB_HOST,
  user     : process.env.AFFORDABLE_DB_USER,
  password : process.env.AFFORDABLE_DB_PASSWORD,
  database : process.env.AFFORDABLE_DB_NAME
});

/**
 * https://www.npmjs.com/package/mysql
 */
connection.getConnection(function(err, connection){
  if (err) throw err;
  connection.query(
    "SELECT *  FROM legalName INNER JOIN sexAndEthnicity ON legalName.id=sexAndEthnicity.id INNER JOIN identificationInformation ON identificationInformation.id=sexAndEthnicity.id INNER JOIN marriageInformation ON marriageInformation.id = identificationInformation.id INNER JOIN phoneNumbers ON phoneNumbers.id = marriageInformation.id INNER JOIN userAddress ON userAddress.id = phoneNumbers.id INNER JOIN emails on emails.userId = userAddress.id INNER JOIN informationProvider ON informationProvider.id = emails.userId INNER JOIN insurance ON insurance.id=informationProvider.id INNER JOIN finances ON finances.id = insurance.id INNER JOIN healthcare ON healthcare.id = finances.id WHERE legalName.id=?", 
    test_user_id, 
    function (err, result, fields) {
      if (err) throw err;
      console.log(result)
      let jsonString = JSON.stringify({
        firstName: result[0].firstName,
        middleName: result[0].middleName,
        lastName: result[0].lastName,
        biologicalSex: result[0].biologicalSex,
        ethnicity: result[0].ethnicity,
        age: _calculateAge(result[0].birthdate),
        birthdate: result[0].birthdate,
        brith: result[0].birthdate.toString(),
        birthDay: result[0].birthdate.toString().substr(8,2),
        birthMonth: getMonthFromString(result[0].birthdate.toString().substr(4,3)).toString(),
        birthYear: result[0].birthdate.toString().substr(11,4),
        ssn: result[0].SSN,
        ssn1: result[0].SSN.substr(0,3),
        ssn2: result[0].SSN.substr(3,2),
        ssn3: result[0].SSN.substr(5,4),
        countryOfBirth: result[0].countryOfBirth,
        marriageStatus: result[0].marriageStatus,
        numberOfChildren: result[0].numberOfChildren,
        phone: result[0].phone,
        phonePart1: result[0].phone.substr(0, 3),
        phonePart2: result[0].phone.substr(3, 3),
        phonePart3: result[0].phone.substr(6, 8),
        address: result[0].street,
        city: result[0].city,
        state: result[0].state,
        zipcode: result[0].zipCode,
        // county: data,
        email: result[0].email,
        informationProvider: result[0].informationProvider,
        relationshipToPatient: result[0].relationshipToPatient,
        placeOfEmployment: result[0].placeOfEmployment,
        hasInsurance: result[0].hasInsurance,
        primaryInsurance: result[0].primaryInsurance,
        planType: result[0].planType,
        policyId: result[0].policyId,
        policyHolder: result[0].policyHolder,
        insuranceFromEmployer: result[0].insuranceFromEmployer,
        companyName: result[0].companyName,
        groupNumberPlanCode: result[0].groupNumberPlanCode,
        hasDeductiblesOrCoPayments: result[0].hasDeductiblesOrCoPayments,
        deductibleAmount: result[0].deductibleAmount,
        copayment: result[0].copayment,
        employmentStatus: result[0].employmentStatus,
        currentEmployer: result[0].currentEmployer,
        positionTitle: result[0].positionTitle,
        grossAnnualIncome: result[0].grossAnnualIncome,
        unemploymentPeriod: result[0].unemploymentPeriod,
        receivesFinancialAssistance: result[0].receivesFinancialAssistance,
        assistanceExplanation: result[0].assistanceExplanation,
        receivesSocialSecurity: result[0].receivesSocialSecurity,
        numberOfPeopleInHousehold: result[0].numberOfPeopleInHousehold
      });
      
      console.log(jsonString);

      // write file out!
      fs.writeFileSync(`./generated/${test_user_id}.json`, jsonString);

      // When done with the connection, release it.
      connection.release();
      
      // Handle error after the release.
      if (err) throw err;
    }
  );     
});



