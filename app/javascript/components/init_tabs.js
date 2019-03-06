const initTabs = () => {
  const tabs = document.querySelector('.tabs');

  const changeTabHeight = () => {

  };

  if (tabs) {
    M.Tabs.init(tabs, {
      swipeable: true,
      onShow: (tab) => {
        let height = 0;
        if (tab.children[0]) {
          height = tab.children[0].scrollHeight + 20;
        }
        document.querySelector(".tabs-content").style.height = height + 'px';
        if (tab.id != 'itineraries') {
          if (document.querySelector('.sticky-cta') == null) { return }
          document.querySelector('.sticky-cta').classList.add('hide-cta');
        } else { document.querySelector('.sticky-cta').classList.remove('hide-cta') }
      }
    });
  };

};

export default initTabs;
