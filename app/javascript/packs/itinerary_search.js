const searchResults = document.querySelector("#search-results");
const searchBar = document.querySelector('#query');
const greenSearch = document.querySelector('#green-search')


const initItinerarySearch = () => {
  greenSearch.addEventListener('click', (e) => {
    searchResults.innerHTML = "";
    Rails.fire(searchBar.closest('form'), 'submit');
  });
  searchBar.addEventListener('keypress', (e) => {
    if (e.keyCode === 13) {
      searchResults.innerHTML = "";
      Rails.fire(searchBar.closest('form'), 'submit');
    }
  });
}

export default initItinerarySearch;

