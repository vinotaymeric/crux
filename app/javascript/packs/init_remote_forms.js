 // Profile edition

const initForm = () => {
  const activities = document.querySelectorAll('#user_activity_level');
  activities.forEach( (element) => {
    element.addEventListener('change', (e) => {
      Rails.fire(e.currentTarget.closest('form'), 'submit')
    });
  });
}

export default initForm;
