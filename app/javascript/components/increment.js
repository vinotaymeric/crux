import $ from 'jquery';

const button = document.querySelector('#test-transition')
const boussole = document.querySelector('.boussole')




const initTransition = () => {
  if (button == null) {
    return ;
  }
    button.addEventListener('click', (e) => {
      console.log("toto1")
      boussole.classList.add("tourne");

});
}

const incrementor = () => {
  $('.count').each(function () {
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


// export default initTransition;
export { initTransition, incrementor};
