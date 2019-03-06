const interested= () =>{
  const btnLetsGo = document.querySelector('#letsGoBtn');
  const choices = document.querySelectorAll('#user_activity_level');
  var x = 0
  choices.forEach(choice => { 
    if (choice.value === "Pas intéressé") {
    x += 1; 
    } 
  });

  if (x === 4) {
    btnLetsGo.disabled = true;
  }else{
    btnLetsGo.disabled = false;
  }
}

export  default interested;


