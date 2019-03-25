const initToggleAdd = () => {
  const addButton = document.querySelectorAll('.fa-plus-circle')
  if (addButton.length == 0) { return }
  addButton.forEach( (element) => {
    element.addEventListener('click', (e) => {
      e.currentTarget.closest('.card').classList.add('selected');
      e.currentTarget.classList.add('fa-mountain');
      e.currentTarget.classList.remove('fa-plus-circle');
    });
  });
}

const initFavorites = () => {
  const favorites = document.querySelectorAll('.fa-plus-circle');
  favorites.forEach( (element) => {
    element.addEventListener('click', (e) => {
      console.log("toto");
      Rails.fire(e.currentTarget.nextElementSibling, 'submit')
    });
  });
}

export { initToggleAdd, initFavorites };
