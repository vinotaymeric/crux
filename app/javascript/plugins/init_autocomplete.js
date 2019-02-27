// app/javascript/plugins/init_autocomplete.js
import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('trip_address');
  if (addressInput) {
    console.log(addressInput);
    places({ container: addressInput });
  }
};

export default initAutocomplete;
