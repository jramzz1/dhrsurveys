// variables for validating Name and Phone Number
var letters = /^[A-Za-z]+$/;
var phoneno = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/;

const error = document.getElementById("MessageShow");

$(document).ready(function () {
    $("#MessageShow").delay(3000).fadeOut(600);
});

function saveValidate(e) {
    // stop form
    function stop() {
        e.preventDefault();
    }

    // Makes error message visible
    function alert() {
        error.innerHTML = "Incorrect Fields";
    }

    // Show error message
    function paint(v) {
        v.classList.add("invalid");     // add invalid css class to input for red border
        v.value = "";                   // Wrong input reset field
    }

    // Check if input fields are valid
    function fields(y, z) {
        if (!y.value || !y.value.match(z)) {
            stop();
            alert();
            paint(y);
        }
    }

    // If first name is null or contains anything other than letters fail validation
    fields(e.innerHTML, letters);

    // If last name is null or contains anything other than letters fail validation
    //fields(lastEdit, letters);

    // If phone number is null or is not a proper number fail validation
    //fields(phoneEdit, phoneno);

    // else continue with form submission
    return;
}