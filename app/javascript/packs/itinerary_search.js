const searchResults = document.querySelector("#search-results");
const searchBar = document.querySelector('#query');

function addTextAreaCallback(textArea, callback, delay) {
    var timer = null;
    textArea.onkeyup = function() {
        if (timer) {
            window.clearTimeout(timer);
        }
        timer = window.setTimeout( function() {
            timer = null;
            if(callback) callback();
        }, delay );
    };
    textArea = null;
}


const search = (textArea) => {
  Rails.fire(textArea.closest('form'), 'submit');
  if (textArea.value.length < 2) {searchResults.innerHTML = ""};
};

const initItinerarySearch = () => {
  if (searchBar === null) {return}
  addTextAreaCallback( searchBar, search(searchBar), 1000 );
}

export default initItinerarySearch;

