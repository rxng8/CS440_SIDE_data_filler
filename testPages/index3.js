// place your javascript code here

// var server = http.researchServer(requestListener);
// server.listen(3000, function() { console.log("Listening on port 3000")});

function validate(){
  var getFirstName = document.getElementById("firstName").value;
  var getLastName = document.getElementById("lastName").value;
  var finalAlert = "";

  // funtion parseName

  finalAlert = `Name is ${getFirstName} ${getLastName}`;
  console.log(firstName);
  alert(finalAlert);

}

function resetForm(){
  document.getElementById("myForm").reset();
}
