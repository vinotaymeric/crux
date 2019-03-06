import 'mapbox-gl/dist/mapbox-gl.css';
// CSS
import 'materialize-css/dist/css/materialize.css';

// JS
import M from 'materialize-css';

// Other imports

import initDatepicker from './init_datepicker'

import { initTransition} from '../components/transition';
import { initToggleRemove, initToggleAdd, initFavorites } from './init_favorite';

import initAutocomplete from '../plugins/init_autocomplete';
import initDrivingTimeOnTrips from './init_driving_time_on_trips'
import initTabs from '../components/init_tabs';
import initForm from './init_remote_forms';

import { initMapbox } from '../plugins/init_mapbox';
import interested from './trip_form'

// Launch js
M.AutoInit();
initTransition();
initAutocomplete();
initDrivingTimeOnTrips();

// Init materialize JS components

initDatepicker();
initTabs();
 // Profile edition

initForm();

 // Set favorite

initFavorites();

const addButton = document.querySelectorAll('.fa-plus-circle')

if (addButton.length != 0) {
initToggleAdd();
initToggleRemove();
}

// Init tooltips
// const menu = document.querySelector('#burger-menu')
// const menuDropdown = document.querySelector('#dropdown1')
// menu.addEventListener('click', (e) => {
//   menuDropdown.classList.toggle('transparent')
// })


 $(document).ready(function(){
    $('.sidenav').sidenav();
  });

initMapbox();

//trip form validation
interested();




// init floating button

  document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.fixed-action-btn');
    var instances = M.FloatingActionButton.init(elems);
  });


// Alert close

$('#alert_close').click(function(){
    $( "#alert_box" ).fadeOut( "slow", function() {
    });
  });

//other

const active = document.querySelector(".active");
const sticky = document.querySelector(".sticky-cta");
console.log(active);


if (active.innerText === "ITINÉRAIRES") {
    sticky.classList.remove("hide");
}

if (active.innerText != "ITINÉRAIRES") {
    console.log("toto");
}
