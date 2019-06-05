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

// console.log(gon.user.email)

// function myfun(){
//      // Write your business logic here
//      console.log('tti');
// }

// button = document.querySelector('.btn-large')

// window.onbeforeunload = function(){
//   myfun();
//   // button.click();
//   return 'Are you sure you want to leave?';
// };

// let finished = false
// let test = 'toto'

// function sleep(milliseconds) {
//   var start = new Date().getTime();
//   for (var i = 0; i < 1e7; i++) {
//     if ((new Date().getTime() - start) > milliseconds){
//       break;
//     }
//   }
// }

// setTimeout(function(){finished = true; }, 3000);

// while (finished === false) {
//   console.log('tti');
//   sleep(1000);
// }

const initStars = () => {
   var width = $(window).width();
   var height = $(window).height();
   var star_count = 250;

   var stars = new Array;
   let i
   for ( i=1; i<= star_count; i++ ) {

     var rand_x =  Math.floor((Math.random()*width)+1);
     var rand_y =  Math.floor((Math.random()*height)+1);
     var rand_color = Math.floor((Math.random()*10)+1);
     var speed = Math.floor((Math.random()*5)+1);


     var element = document.createElement('div');
     element.className = "star star-" + rand_color;
     element.style.left = rand_x + "px";
     element.style.top = rand_y + "px";
     element.setAttribute("data-speed", speed);
     document.body.appendChild( element );

     stars[i] = element;

   }

   var interval = setInterval(function(){

     for ( i=1; i<stars.length; i++ ) {

       var left = stars[i].style.left;
       if ( left === "0px" ) {
         stars[i].style.left = (width - 10) + "px";
       } else {
         stars[i].style.left = parseInt( left ) - stars[i].getAttribute("data-speed") + "px";
       }
     }
   },1000/60);

   setTimeout(function() {
    stars = document.querySelectorAll('p')

    stars.forEach(function(element) {
      element.style.visibility = "hidden";
    });
   }, 5000)
}


initStars()
