import $ from 'jquery';

const button = document.querySelector('#test-transition')
const boussole = document.querySelector('.boussole')
const curtain = document.querySelector('.curtain')
const footer = document.querySelector('.page-footer')
const greenButton = document.querySelector('#new_trip')


const initTransition = () => {
  if (button == null) {
    return ;
  }
    button.addEventListener('click', (e) => {
      console.log("toto1")
      greenButton.classList.add("transparent");
      // footer.classList.add("transparent");
      curtain.classList.add("curtain-up");
      boussole.classList.add("tourne");
});
}

const incrementor = () => {
  $('.count').each(function () {
    $(this).prop('Counter',0).animate({
        Counter: $(this).text()
    }, {
        duration: 10000,
        easing: 'swing',
        step: function (now) {
            $(this).text(Math.ceil(now));
        }
    });
});
};


// export default initTransition;
export { initTransition, incrementor};
