const algoliaSearch = document.querySelector("#algoliaSearch");
var client = algoliasearch("L83PWH35UP", "6c88249b89170302d0939419d95a4b00");
var index = client.initIndex('Itinerary');

const search = () => {
  if (algoliaSearch === null) {return}
  algoliaSearch.addEventListener('keyup', (event) => {
    grid.innerHTML = "";
    var keyword = event.currentTarget.value;
    index.search(keyword, function(err, content) {

      content.hits.forEach(element => {
       addItineraryCard(element)
     });

    });
  });
}

const grid = document.querySelector(".algolia-iti");

const html = (json) => {
const new_html = `
                <div class="col s12 m4">
                <a href="/itineraries/${json.id}/">
                  <div class="card small">
                    <div class="card-image waves-effect waves-block waves-light">
                      <img class="activator" src=${json.picture_url}>
                    </div>
                    <div class="card-content">
                      <span class="title-card ellsipsised card-title activator grey-text text-darken-4">${json.name}</span>
                    </div>
                  </div>
                  </a>
                </div>`;
  return new_html;
    };


const  addItineraryCard = (json) => {
  grid.insertAdjacentHTML('beforeend', html(json));
};

export default search;


