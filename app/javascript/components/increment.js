import $ from 'jquery';

const button = document.querySelector('#test-transition')
const boussole = document.querySelector('.boussole')
const curtain = document.querySelector('.curtain')
const footer = document.querySelector('.page-footer')
const greenButton = document.querySelector('#new_trip')
const list = document.querySelector('.list')

function sleep(milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds){
      break;
    }
  }
}


const incrementor = () => {
  $('.count').each(function () {
    $(this).prop('Counter',0).animate({
        Counter: $(this).text()
    }, {
        duration: 12000,
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
      greenButton.classList.add("transparent");
      // footer.classList.add("transparent");
      curtain.classList.add("curtain-up");
      boussole.classList.add("tourne");
      incrementor();
  });
}



// export default initTransition;
export { initTransition};
