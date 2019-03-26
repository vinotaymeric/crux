
const initItinerarySearch = () => {
  const searchResults = document.querySelector("#search-results");
  const searchBar = document.querySelector('#query');
  if (searchBar === null) {return}

  searchBar.addEventListener('keyup', (e) => {
    // console.log(e.currentTarget.value.length);
    // console.log(e.currentTarget.value.length);
    Rails.fire(e.currentTarget.closest('form'), 'submit');
    // if (e.currentTarget.value.length < 2) {console.log('youhou')};
    if (e.currentTarget.value.length < 2) {searchResults.innerHTML = ""};
  });
}

export default initItinerarySearch;
