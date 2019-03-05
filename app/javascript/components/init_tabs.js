const initTabs = () => {
  const tabs = document.querySelector('.tabs');

  if (tabs) {
    M.Tabs.init(tabs, {
      swipeable: true,
      onShow: (tab) => {
        let height = 0;
        if (tab.children[0]) {
          height = tab.children[0].scrollHeight + 20;
        }
        document.querySelector(".tabs-content").style.height = height + 'px';
        console.log(tab);
        console.log(tab.children[0]);
        console.log(tab.children[0].scrollHeight);
      }
    });
  };
};

export default initTabs;
