const initModals = () => {
  const modals = document.querySelectorAll('.modal');

  if (modals === null) {
    return
  };

  const instances = M.Modal.init(modals);

};

export default initModals;
