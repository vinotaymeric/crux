const initTabs = initMapbox => {
  const tabs = document.querySelector(".tabs");
  let callInitMap = true;

  const changeTabHeight = () => {};

  if (tabs) {
    M.Tabs.init(tabs, {
      swipeable: false,
      onShow: tab => {
        if (tab.id != "itineraries") {
          const cta = document.querySelector(".sticky-cta");
          if (cta)
            document.querySelector(".sticky-cta").classList.add("hide-cta");
        } else {
          document.querySelector(".sticky-cta").classList.remove("hide-cta");
        }

        if (callInitMap) {
          initMapbox();
          callInitMap = false;
        }
      }
    });
  }
};

export default initTabs;
