const initItinerarySearch = () => {
  const searchBar = document.querySelector('#query');
  if (searchBar === null) {return}

  searchBar.addEventListener('keyup', (e) => {
    Rails.fire(e.currentTarget.closest('form'), 'submit')
  });
}

export default initItinerarySearch;
