const adjustBanner = () => {
  const bannerForm = document.querySelector(".banner-form");
  const inputs = document.querySelectorAll(".form-control");
  if ((bannerForm === null) || (inputs === null)) { return }
  inputs.forEach((input) => {
    input.addEventListener('focus', (e) => {
      console.log("je suis focus")
      bannerForm.classList.add("banner-adjust")
    });
    input.addEventListener('focusout', (e) => {
      console.log("je suis plus focus")
      bannerForm.classList.remove("banner-adjust")
    });
  });
}

export default adjustBanner;
