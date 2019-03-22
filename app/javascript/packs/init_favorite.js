const activateButtonBasecampValidation = () => {
  const littleMountain = document.querySelector('.fa-mountain')
  if (littleMountain === null) {
    document.getElementById("validation-basecamp-button").classList.add("transparent");
  }
  else {
    document.getElementById("validation-basecamp-button").classList.remove("transparent");
  }
}

const initToggleAdd = () => {
  const addButton = document.querySelectorAll('.fa-plus-circle')
  addButton.forEach( (element) => {
    element.addEventListener('click', (e) => {
      e.currentTarget.closest('.card').classList.add('selected');
      e.currentTarget.classList.add('fa-mountain');
      e.currentTarget.classList.remove('fa-plus-circle');
      activateButtonBasecampValidation();
    });
  });
}

const initFavorites = () => {
  const favorites = document.querySelectorAll('.fa-plus-circle');
  favorites.forEach( (element) => {
    element.addEventListener('click', (e) => {
      Rails.fire(e.currentTarget.nextElementSibling, 'submit')
    });
  });
}


const initValidateButton = () => {
  const validationButton = document.getElementById("validation-basecamp-button");
  const littleMountain = document.querySelector('.fa-mountain')
  if (validationButton == null){
    return
  }
  if (littleMountain === null) {
    validationButton.classList.add("transparent");
  }
}

export { initToggleRemove, initToggleAdd, initFavorites, initValidateButton };
