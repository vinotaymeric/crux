 // Profile edition

const initForm = () => {
  const activities = document.querySelectorAll('.form-control.select.optional');
  activities.forEach( (element) => {
    element.addEventListener('change', (e) => {
      Rails.fire(e.currentTarget.closest('form'), 'submit')
    });
  });
}

export default initForm;
