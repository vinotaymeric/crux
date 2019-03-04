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





// const resizeTab = () => {
//   let maxHeight = 0;
//   document.querySelectorAll('.carousel-item').forEach((item) => {
//     if (item.scrollHeight > maxHeight) {
//       maxHeight = item.scrollHeight;
//     }
//   });
//   console.log(maxHeight)
//   document.querySelector(".tabs-content").style.height = maxHeight + 'px';
// }

// resizeTab();
// window.addEventListener('resize', resizeTab);
