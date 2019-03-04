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
console.log(activities);

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
