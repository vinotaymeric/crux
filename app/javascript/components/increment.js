import $ from 'jquery';

const button = document.querySelector('#test-transition')
const boussole = document.querySelector('.boussole')
const curtain = document.querySelector('.curtain')
const footer = document.querySelector('.page-footer')
const greenButton = document.querySelector('#new_trip')
const rowIti = document.querySelector('#row-iti')
const rowMassif = document.querySelector('#row-massif')
const rowBasecamp = document.querySelector('#row-basecamp')

function sleep(milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds){
      break;
    }
  }
}


const incrementor = (id) => {
  $(id).each(function () {
    $(this).prop('Counter',0).animate({
        Counter: $(this).text()
    }, {
        duration: 4000,
        easing: 'swing',
        step: function (now) {
            $(this).text(Math.ceil(now));
        }
    });
});
};


const initTransition = () => {
  if (button == null) {
    return ;
  }
    button.addEventListener('click', (e) => {
      setTimeout(function(){ console.log("toto"); }, 5000);

      greenButton.classList.add("transparent");
      // footer.classList.add("transparent");
      curtain.classList.add("curtain-up");
      // boussole.classList.add("tourne");
      setTimeout(function(){ boussole.classList.add("tourne"); }, 1000);
      setTimeout(function(){ console.log("toto"); rowIti.classList.remove("transparent"); incrementor('#itinerary-count');}, 1200);
      setTimeout(function(){ console.log("toto"); rowBasecamp.classList.remove("transparent"); incrementor('#basecamp-count');}, 5000);
      setTimeout(function(){ console.log("toto"); rowMassif.classList.remove("transparent"); incrementor('#massif-count'); }, 9000);

  });
}



// export default initTransition;
export { initTransition};
