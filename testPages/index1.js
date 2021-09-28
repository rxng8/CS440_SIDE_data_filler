// place your javascript code here

// var server = http.researchServer(requestListener);
// server.listen(3000, function() { console.log("Listening on port 3000")});

function validate(){
  // if statements about whether or not fields are filled
  //document.getElementsByName, document.getElementById
  var numCheck = document.getElementsByClassName("phone");
  var radButtons = document.getElementsByName("period");  //stores radio button input
  // var checkBoxes = document.getElementsByClassName("check");  //stores checkbox input
  var idCheck = document.getElementsByClassName("ID");
  var conditionCheck = document.getElementById("conditions");
  // console.log(numCheck)

  //messages for the respective alerts
  var radAlert = "no time period selected";
  // var checkAlert = "no conditions selected";
  var numAlert = "invalid phone number";
  var idAlert = "invalid ID input";
  var conditionAlert = "please select a condition";
  var finalAlert = "" //stores all alerts in a single variable to be used once

  //check if phone number input is a number
  // var numError = new Error(numAlert);
  numCheck = Array.prototype.slice.call(numCheck);
  // var numCheck2 = numCheck.map(x => isNaN(x.value));
  var numCheck2 = numCheck.reduce((x, y) => x||isNaN(y.value), false);
  // console.log(numCheck2);
  if (numCheck2 == true) {
    finalAlert = finalAlert + "\n" + numAlert;
    // throw numError;
  }

  //checks checkbox input
  // checkBoxes = Array.prototype.slice.call(checkBoxes);
  // var checkBxes = checkBoxes.reduce((x, y) => x||y.checked, false);
  // if (checkBxes == false) {
  //   finalAlert = finalAlert + "\n" + checkAlert;
  // }

  //checks radio input
  radButtons = Array.prototype.slice.call(radButtons);
  var radCheck = radButtons.reduce((x, y) => x||y.checked, false);
  if (radCheck == false) {
    finalAlert = finalAlert + "\n" + radAlert;
  }

  // console.log(conditionCheck);

  idCheck = Array.prototype.slice.call(idCheck);
  var idBool = false;
  // console.log(idCheck);
  function parseID (array) {
    if (((array[0]).value).charAt(0) == "A" && ((array[1]).value).charAt(0) == "B") {
      if (!isNaN(parseInt((array[0].value).substring(1))) && !isNaN(parseInt((array[1].value).substring(1)))) {
        return true;
      }
    }
    return false;
  }

  conditionCheck = conditionCheck.options[conditionCheck.selectedIndex].value;
  console.log(conditionCheck);
  // console.log(parseID(idCheck));

  if (parseID(idCheck) == false) {
    finalAlert = finalAlert + "\n" + idAlert;
  }

  if (finalAlert == "") {
    finalAlert = "Do you want to submit this form?"
    alert(finalAlert);
    return true;
  } else {
    alert(finalAlert);
    return false;
  }
}

function resetForm(){
  document.getElementById("myForm").reset();
}
