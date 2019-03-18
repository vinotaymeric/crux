
const interested = () => {
  updateCTA();
  const choices = document.querySelectorAll('#user_activity_level');
  choices.forEach((choice) => {
    choice.addEventListener('change', interested);
  });
}

const updateCTA = () =>{
  var x = 0
  const btnLetsGo = document.querySelector('#letsGoBtn');
  const choices = document.querySelectorAll('#user_activity_level');
  if (btnLetsGo == null){
    return
  }
  choices.forEach(choice => {
    if (choice.value === "Niveau ?") {
      x += 1;
    }
  });

  if (x == 4) {
    btnLetsGo.disabled = true;
  }else{
    btnLetsGo.disabled = false;
  }
}

export default interested;



