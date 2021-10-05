const express = require('express');
var request = require('request');
const {spawn} = require('child_process');
var mysql = require('mysql');
const mail = require('./mailServer');

const app = express();

const PORT = 4000;

const HOST = 'vacancy.cs.umd.edu'

app.use(express.json());

var con = mysql.createPool({
  host: "vacancy.cs.umd.edu",
  user: "root",
  password: "password",
  database: "Affordable"
});

//vacancy.cs.umd.edu
//root
//Matthew1!

function _calculateAge(birthday) {
    var ageDifMs = Date.now() - birthday.getTime();
    var ageDate = new Date(ageDifMs);
    return Math.abs(ageDate.getUTCFullYear() - 1970);
}

function getCounty (zipcode, callback) {
    con.query("SELECT county_name FROM zips WHERE zips.zip = ?", zipcode, function (err, result, fields) {
    if (err) {
      mail.mailfunc(err.toString());
    } else {
      try{
        callback(null, result[0].county_name);
      } catch (err) {
        mail.mailfunc(err.toString());
      }
    }
  })
}

function getMonthFromString(mon){
   return new Date(Date.parse(mon +" 1, 2012")).getMonth()+1
}


app.get('/user/:id', (req, res) =>{
	var user = req.params.id;
	res.status(200);
	con.getConnection(function(err) {
	  if (err) mail.mailfunc(err.toString());
	  con.query("SELECT *  FROM legalName INNER JOIN sexAndEthnicity ON legalName.id=sexAndEthnicity.id INNER JOIN identificationInformation ON identificationInformation.id=sexAndEthnicity.id INNER JOIN marriageInformation ON marriageInformation.id = identificationInformation.id INNER JOIN phoneNumbers ON phoneNumbers.id = marriageInformation.id INNER JOIN userAddress ON userAddress.id = phoneNumbers.id INNER JOIN emails on emails.userId = userAddress.id INNER JOIN informationProvider ON informationProvider.id = emails.userId INNER JOIN insurance ON insurance.id=informationProvider.id INNER JOIN finances ON finances.id = insurance.id INNER JOIN healthcare ON healthcare.id = finances.id WHERE legalName.id=?", user, function (err, result, fields) {
	    if (err) mail.mailfunc(err.toString());
      getCounty(result[0].zipCode, function(err,data){
            res.json({
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
              county: data,
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
              numberOfPeopleInHousehold: result[0].numberOfPeopleInHousehold,
                       });
      });
      // the output should be an actual json, not a json with one entry which is a string to be printed
	  });
	});
}
);


app.get('/script/:orgId/:grantId/', (req, res, next) => {
	var org = req.params.orgId;
	var grant = req.params.grantId;

	// check to see if script exists (potentially store in db?)
	// TO DO: get the location of the script

	res.status(200); // python script exists
	res.json({ location: `${org}${grant}.side`, message: `check if python script exists for organization ${org} for application ${grant}`});
  // TO DO: update based on location
}
);

app.post('/submit/', (req, res, next) => {
	var org = req.body.orgId;
	var grant = req.body.grantId;
	var user = req.body.userId;

	// check for python script existence
	var orgInfo = {
		"orgId": org,
		"grantId": grant,
	};
	request({
		url: `http://${HOST}:${PORT}/script/${org}/${grant}`,
		method: "GET",
		json: true,
		body: orgInfo
	}, function (error, response, body) {
		if (response.statusCode == 200) {
			// script exists, submit application
			var location = response.body.location;
			// get user info
			request({
				url: `http://${HOST}:${PORT}/user/${user}`,
				method: "GET"
			}, function (gerr, gres, gbody) {
				if (gres.statusCode == 200){
					var userInfo = gres.body;
					var userFile = `./tmp/${user}.json`;
					try {
						fs.writeFileSync(userFile, userInfo, {flag: 'w'});
						console.log("theoretically wrote to file...");
					} catch (err) {
						res.status(400);
						res.json({message: "writing to file failed"});
            mail.mailfunc(err.toString());
					}
					console.log("userfile: " + userFile);
					console.log("location: " + location);

					res.status(200);
					res.json({message: `python script for ${org} ${grant} exists at ${location} and user info for ${user} is ${userInfo}`});


					var dataToSend;
					const python = spawn('python3', ['am_filler.py', location, userFile]);
					python.stdout.on('data', function (data) {
						console.log('Pipe data from python script ...');
						dataToSend = data.toString();
						console.log(dataToSend);
					   });
					python.on('close', (code) => {
						console.log(`child process close all stdio with code ${code}`);
						//res.json({message: `closed with code ${code}`});
						});

					//res.status(200);
					//res.json({message: `python script for ${org} ${grant} exists at ${location} and user info for ${user} is ${userInfo}`});
				} else {
					res.status(404);
					res.json({message: `python script existed for ${org} ${grant} but retrieving user info for ${user} failed.`});
          mail.mailfunc("python script existed for " + org + " " + grant + " but retrieving user info for " + user + " failed.");
				}
			});

		} else {
			res.status(404);
			res.json({message: "script dne"});
		}
	});
}
);

app.listen(PORT, HOST, () =>

	console.log(`Your server is running on port ${HOST} ${PORT}`));
