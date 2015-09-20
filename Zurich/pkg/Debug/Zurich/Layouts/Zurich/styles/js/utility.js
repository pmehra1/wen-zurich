
function allowOnlyNumbers(value) {
    if (event.keyCode < 48 || event.keyCode > 57) {
        if (event.keyCode == 46) {
            var onlyNumberLocation = value.indexOf(".");
            if (onlyNumberLocation >= 0) {
                event.returnValue = false;
            }
        }
        else    
        event.returnValue = false;
    }
}


function allowOnlyNumbersForDates() {
    if (event.keyCode < 47 || event.keyCode > 57) {
        event.returnValue = false;
    }
}



var dtCh = "/";
var minYear = 1900;
var maxYear = 2100;

function isInteger(s) {
    var i;
    for (i = 0; i < s.length; i++) {
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag) {
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++) {
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary(year) {
    // February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
}
function DaysArray(n) {
    for (var i = 1; i <= n; i++) {
        this[i] = 31
        if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
        if (i == 2) { this[i] = 29 }
    }
    return this
}

function isDate(dtStr) {
    
    var daysInMonth = DaysArray(12)
    var pos1 = dtStr.indexOf(dtCh)
    var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
    var strDay = dtStr.substring(0, pos1)
    var strMonth = dtStr.substring(pos1 + 1, pos2)
    var strYear = dtStr.substring(pos2 + 1)
    strYr = strYear
    if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
    if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
    for (var i = 1; i <= 3; i++) {
        if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
    }
    month = parseInt(strMonth)
    day = parseInt(strDay)
    year = parseInt(strYr)
    if (pos1 == -1 || pos2 == -1) {
        return false
    }
    if (strMonth.length < 1 || month < 1 || month > 12) {
        return false
    }
    if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
        return false
    }
    if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
        return false
    }
    if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
        return false
    }
    return true
}




function removeTrailingZeroes(source) {
    var result = "";
    
    if (source != null) {
        var c;
        for (var i = 0; i < source.length; i++) {
            c = source.charAt(i);
            if (c != '0') {
                result = source.substring(i);
                break;
            }
        }
    }
    
    if (result == "")
        result = "0";

    return result;
}


function fixedToZero(source) {
    var result = source.toFixed(2);
    return result;
}

function calculateAge(birthMonth, birthDay, birthYear) {
    todayDate = new Date();
    todayYear = todayDate.getFullYear();
    todayMonth = todayDate.getMonth()+1;
    todayDay = todayDate.getDate();
    age = todayYear - birthYear;
    if (todayMonth < birthMonth) {
        age--;
    }

    if (birthMonth == todayMonth && todayDay < birthDay) {
        age--;
    }
    return age;
}

