import 'mapbox-gl/dist/mapbox-gl.css';
// Materialize
import 'materialize-css/dist/css/materialize.css';
import M from 'materialize-css';

// Other imports
import initDatepicker from './init_datepicker'
import adjustBanner from './adjust_banner'
import initItinerarySearch from './itinerary_search'
import { initTransition} from '../components/transition';
import { initToggleAdd, initFavorites } from './init_favorite';
import { initActivityIcons, initManageButton, initUpdateButton } from './trip_form';
import initAutocomplete from '../plugins/init_autocomplete';
import initDrivingTimeOnTrips from './init_driving_time_on_trips'
import initTabs from '../components/init_tabs';
import initForm from './init_remote_forms';
import { initMapbox } from '../plugins/init_mapbox';

M.AutoInit();

initTransition();
initAutocomplete();
initDrivingTimeOnTrips();
initTabs(initMapbox);
initDatepicker();
initForm();
initToggleAdd();
initFavorites();
initMapbox();
initToggleAdd();
adjustBanner();
initItinerarySearch();
initActivityIcons();
initManageButton();
initUpdateButton();

// Init Materialize components

document.addEventListener('DOMContentLoaded', function() {
  var elems = document.querySelectorAll('.fixed-action-btn');
  var instances = M.FloatingActionButton.init(elems);
});

document.addEventListener('DOMContentLoaded', function() {
  var elems = document.querySelectorAll('.modal');
  var instances = M.Modal.init(elems);
});

// Other quick init

$('#alert_close').click(function(){
    $( "#alert_box" ).slideUp( "slow", function() {
    });
  });

 $(document).ready(function(){
    $('.sidenav').sidenav();
  });

// The CTA disappears on tabs other than "Itineraries"
const buttonTabs = () => {
  const active = document.querySelector(".active");
  const sticky = document.querySelector(".sticky-cta");
  if (active === null) { return }
  if (active.innerText === "ITINÉRAIRES") {
      sticky.classList.remove("hide");
  }
}

buttonTabs();

console.log(gon.user.email)
