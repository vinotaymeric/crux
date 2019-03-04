// CSS
import 'materialize-css/dist/css/materialize.css';

// JS
import M from 'materialize-css';

// Other imports

import initDatepicker from './init_datepicker'

import { initTransition} from '../components/transition';
import initAutocomplete from '../plugins/init_autocomplete';
import initDrivingTimeOnTrips from './init_driving_time_on_trips'
import initTabs from '../components/init_tabs';

// Launch js
initTransition();
initAutocomplete();
initDrivingTimeOnTrips();

// Init materialize JS components
initDatepicker();
initTabs();
 // Profile edition

const activities = document.querySelectorAll('#user_activity_level');

activities.forEach( (element) => {
  element.addEventListener('click', (e) => {
    e.preventDefault();
    const value = e.currentTarget.value;
    e.currentTarget.closest('form').submit();
  });
});


 // Set favorite

const favorites = document.querySelectorAll('#favorite');
favorites.forEach( (element) => {
  element.addEventListener('click', (e) => {
    e.preventDefault();
    e.currentTarget.nextElementSibling.submit();
  });
});

const addButton = document.querySelectorAll('.fa-plus-circle')

addButton.forEach( (element) => {
  element.addEventListener('click', (e) => {
    console.log("toto")
    e.currentTarget.closest('.card').classList.toggle('selected');
  });
});


