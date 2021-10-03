/** @file utils.js */

export function getMonthFromString(mon){
  return new Date(Date.parse(mon +" 1, 2012")).getMonth() + 1
}

export function _calculateAge(birthday) {
  var ageDifMs = Date.now() - birthday.getTime();
  var ageDate = new Date(ageDifMs);
  return Math.abs(ageDate.getUTCFullYear() - 1970);
}