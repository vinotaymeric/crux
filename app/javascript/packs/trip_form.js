const formButton = document.querySelector("#letsGoBtn");
const selectedActivities = document.querySelector(".selected-icon");

const showForm = (activity) => {
  const formDiv = document.querySelector(`.icon-target#${activity}`)
  const form = document.querySelector(`.form-control.select.optional.${activity}`);
  form.closest('select').value = "Niveau ?";
  Rails.fire(form.closest('form'), 'submit')
  formDiv.classList.toggle("hidden");
}

const initActivityIcons = () => {
  const source_icons = document.querySelectorAll(".icon-source");
  source_icons.forEach( (element) => {
    element.addEventListener('click', (e) => {
        e.currentTarget.classList.toggle("selected-icon");
        showForm(e.currentTarget.id);
      });
  });
}

const countSelectedActivities = () => {
  const chosenActivities = document.querySelectorAll(".selected");
  var count = 0;
  for(var i = 0; i < chosenActivities.length; ++i){
      if(chosenActivities[i].innerText != "Niveau ?")
        count++;
  }
  return count
}

const initManageButton = () => {
  if (selectedActivities === null) {formButton.classList.add("hidden")};
}

const initUpdateButton = () => {
  const li = document.querySelectorAll("li");
  li.forEach( (element) => {
    element.addEventListener('click', (e) => {
      console.log(countSelectedActivities());
      if (countSelectedActivities() > 0) {formButton.classList.remove("hidden")};
    });
  });
}

export { initActivityIcons, initManageButton, initUpdateButton };



