const searchResults = document.querySelector("#search-results");
const searchBar = document.querySelector('#query');
const greenSearch = document.querySelector('#green-search')


const initItinerarySearch = () => {
  if (greenSearch === null) { return };
  greenSearch.addEventListener('click', (e) => {
    searchResults.innerHTML = "";
    Rails.fire(searchBar.closest('form'), 'submit');
  });
  if (searchBar === null) { return };
  searchBar.addEventListener('keypress', (e) => {
    if (e.keyCode === 13) {
      searchResults.innerHTML = "";
      Rails.fire(searchBar.closest('form'), 'submit');
    }
  });
}

export default initItinerarySearch;

