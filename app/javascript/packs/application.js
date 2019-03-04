// CSS
import 'materialize-css/dist/css/materialize.css';

// JS
import M from 'materialize-css';

// Other imports

import initDatepicker from './init_datepicker'
// import initTransition from '../components/increment';
import { initTransition} from '../components/increment';
import initAutocomplete from '../plugins/init_autocomplete';
import initDrivingTimeOnTrips from './init_driving_time_on_trips'

// Launch js
initTransition();
initAutocomplete();
initDatepicker();
initDrivingTimeOnTrips();

// Init materialize JS components
const tabs = document.querySelector('.tabs');

if (tabs) {
  M.Tabs.init(tabs, {
    swipeable: true,
    onShow: (tab) => {
      let height = 0;
      console.log(tab.children[0])
      if (tab.children[0]) {
        height = tab.children[0].scrollHeight + 20;
      }
      console.log(height)
      document.querySelector(".tabs-content").style.height = height + 'px';
    }
  });
};

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
    e.currentTarget.classList.toggle('fa-mountain');
    e.currentTarget.classList.toggle('fa-plus-circle');
  });
});


