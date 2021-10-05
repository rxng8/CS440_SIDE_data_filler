var nodemailer = require('nodemailer');

function mailfunc(errormessage){
  var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'affordable.python@gmail.com',
      pass: '0ldb4y0n3v3ryth1ng'
    }
  });
  var mailOptions = {
    from: 'affordable.python@gmail.com',
    to: 'umdaffordable@gmail.com',
    subject: 'Error Message',
    text: errormessage,
  };
  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    } else {
      console.log('Email sent: ' + info.response);
    }
 });
}
exports.mailfunc= mailfunc;
