 // Profile edition

const initForm = () => {
  const activities = document.querySelectorAll('#user_activity_level');
  activities.forEach( (element) => {
    element.addEventListener('click', (e) => {
      e.currentTarget.closest('form').submit();
      e.preventDefault();
    });
  });
}

export default initForm;
