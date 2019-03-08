const initTabs = () => {
  const tabs = document.querySelector('.tabs');

  const changeTabHeight = () => {

  };

  if (tabs) {
    M.Tabs.init(tabs, {
      swipeable: false,
      onShow: (tab) => {
        if (tab.id != 'itineraries') {
          if (document.querySelector('.sticky-cta') == null) { return }
          document.querySelector('.sticky-cta').classList.add('hide-cta');
        } else { document.querySelector('.sticky-cta').classList.remove('hide-cta') }
      }
    });
  };

};

export default initTabs;
