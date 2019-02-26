// CSS
import 'materialize-css/dist/css/materialize.css';

// JS
import M from 'materialize-css';

// Init materialize JS components
const tabs = document.querySelector('.tabs');

if (tabs) {
  M.Tabs.init(tabs);
};

 document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.modal');
    var instances = M.Modal.init(elems);
  });

 // Profile edition

const activities = document.querySelectorAll('.form-control');
console.log(activities);

activities.forEach( (element) => {
  element.addEventListener('click', (e) => {
    const value = e.currentTarget.value;
    e.currentTarget.closest('form').submit();
  });
});
