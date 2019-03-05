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

// Launch js
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



// init discovery

  // $(document).ready(function(){
  //   $('.tap-target').tapTarget();
  // });
