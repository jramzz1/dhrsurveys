// variables for validating Name and Phone Number
var letters = /^[A-Za-z]+$/;
var phoneno = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/;

// variables for storing user inputs
const first = document.getElementById("first");
const last = document.getElementById("last");
const phone = document.getElementById("pat_phone");
const error = document.getElementById("nameError");
const courtesy = document.getElementsByName('rating1');

// listens for submit button press
document.getElementById("submit").addEventListener("click", validate);

function validate(e) {

  // On Back button press clear form (form has already been submitted)
  $(window).bind("pageshow", function() {
      document.getElementById("submission").reset();
      error.classList.add("hidden");
  });


  // Validate radio selections before submiting, if not all selected unable to go forward
    var total = 0;                          // Keep Track of all radios checked

    // stop form
    function stop() {
        e.preventDefault();
    }

    // Makes error message visible
    function alert() {
        error.classList.add("visible");
        error.setAttribute("aria-hidden", false);
        error.setAttribute("aria-invalid", true);
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

  $('input:radio').each(function() {      // Loop through all radios looking for 5 checked
    if($(this).is(':checked')) {
      total++;
    }
  });

  if(total < 5){                          // If less than 5 (total survey questions) checked, there are radios missing
    stop();
    alert();
  }

  first.classList.remove("invalid");    // On each submit click reset input field css class
  last.classList.remove("invalid");     //
  phone.classList.remove("invalid");    //

  // If first name is null or contains anything other than letters fail validation
  fields(first,letters);

  // If last name is null or contains anything other than letters fail validation
  fields(last,letters);

  // If phone number is null or is not a proper number fail validation
  fields(phone,phoneno);

  // else continue with form submission
  return;
}