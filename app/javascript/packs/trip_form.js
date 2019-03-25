const interested = () => {
  updateCTA();
  const choices = document.querySelectorAll('#user_activity_level');
  choices.forEach((choice) => {
    choice.addEventListener('change', interested);
  });
}


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

export { interested, initActivityIcons };



