const initToggleRemove = () => {
  const removeButton = document.querySelectorAll('.fa-mountain')
  removeButton.forEach( (element) => {
    element.addEventListener('click', (e) => {
      e.currentTarget.classList.toggle('fa-mountain');
      e.currentTarget.classList.toggle('fa-plus-circle');
    });
  });
}

const initToggleAdd = () => {
  const addButton = document.querySelectorAll('.fa-plus-circle')
  addButton.forEach( (element) => {
    element.addEventListener('click', (e) => {
      e.currentTarget.closest('.card').classList.toggle('selected');
      e.currentTarget.classList.toggle('fa-mountain');
      e.currentTarget.classList.toggle('fa-plus-circle');
    });
  });
}

const initFavorites = () => {
  const favorites = document.querySelectorAll('#favorite');
  favorites.forEach( (element) => {
    element.addEventListener('click', (e) => {
      Rails.fire(e.currentTarget.nextElementSibling, 'submit')
    });
  });
}


const initButtonBasecampValidation = () => {
  const buttonBasecampValidation = document.querySelectorAll('#validation-basecamp-button');
  const littleMountain = document.querySelectorAll('.fa-mountain')
  if (littleMountain.empty) {
    console.log("je suis null")
    console.log(littleMountain.count)
    // buttonBasecampValidation.disabled = true;
  }
  else {
    console.log("je suis else")
    console.log(littleMountain.type)
    // buttonBasecampValidation.disabled = false;
  }
}

export { initToggleRemove, initToggleAdd, initFavorites, initButtonBasecampValidation };
