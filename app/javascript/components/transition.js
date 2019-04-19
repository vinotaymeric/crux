import $ from "jquery";

const form = document.querySelector("#new_trip");
const boussole = document.querySelector(".boussole");
const curtain = document.querySelector(".curtain");
const rowIti = document.querySelector("#row-iti");
const rowWeather = document.querySelector("#row-weather");
const rowMassif = document.querySelector("#row-massif");
const rowBasecamp = document.querySelector("#row-basecamp");
const userActivityFields = document.querySelectorAll("#user_activity_level");
const tripAddress = document.querySelector("#trip_address");
const tripStartDate = document.querySelector("#trip_start_date");
const tripEndDate = document.querySelector("#trip_end_date");
var valid = [];

const verif = field => {
  if (field.value === "") {
    field.classList.add("mandatory");
    valid.push("n");
  } else {
    valid.push("y");
  }
};

const incrementor = id => {
  $(id).each(function() {
    $(this)
      .prop("Counter", 0)
      .animate(
        {
          Counter: $(this).text()
        },
        {
          duration: 2000,
          easing: "swing",
          step: function(now) {
            $(this).text(Math.ceil(now));
          }
        }
      );
  });
};

const initTransition = () => {
  if (form == null) {
    return;
  }
  form.addEventListener("submit", e => {
    e.preventDefault();
    verif(tripAddress);
    verif(tripStartDate);
    verif(tripEndDate);
    userActivityFields.forEach(function(userActivityField) {
      verif(userActivityField);
    });
    if (valid.includes("n")) {
      valid = [];
      document
        .querySelector("#empty-field-message")
        .classList.remove("transparent");
    } else {
      form.classList.add("transparent");
      document.querySelectorAll(".user_activity_level").forEach(inputField => {
        inputField.classList.add("transparent");
      });
      curtain.classList.add("curtain-up");
      setTimeout(function() {
        boussole.classList.add("tourne");
      }, 1000);
      setTimeout(function() {
        rowIti.classList.remove("transparent");
        incrementor("#itinerary-count");
      }, 1000);
      setTimeout(function() {
        rowBasecamp.classList.remove("transparent");
        incrementor("#basecamp-count");
      }, 3000);
      setTimeout(function() {
        rowWeather.classList.remove("transparent");
        incrementor("#weather-count");
      }, 5000);
      setTimeout(function() {
        rowMassif.classList.remove("transparent");
        incrementor("#massif-count");
      }, 7000);
      setTimeout(function() {
        form.submit();
      }, 5000);
    }
  });
};

// export default initTransition;
export { initTransition };
