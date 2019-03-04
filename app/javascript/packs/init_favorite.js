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
      e.preventDefault();
      e.currentTarget.nextElementSibling.submit();
    });
  });
}

export { initToggleRemove, initToggleAdd, initFavorites };
