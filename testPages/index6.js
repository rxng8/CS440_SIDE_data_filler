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
