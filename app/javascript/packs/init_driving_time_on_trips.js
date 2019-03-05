
const initDrivingTimeOnTrips = () => {

const addDrivingTimeToCard = (card, drivingTime) => {
    card.querySelector('#itinerary-number').insertAdjacentHTML('AfterEnd', `<br><p id="driving-time"><i class="fas fa-car"></i> ${drivingTime}</p>`);
};

const fetchDrivingTime = (ori_lat, ori_long, desti_lat, desti_long, orsApiKey) => {
  const url = `https://api.openrouteservice.org/matrix?api_key=${orsApiKey}&profile=driving-car&locations=${ori_long},${ori_lat}%7C${desti_long},${desti_lat}`;
  return fetch(url).then(response => response.json()).then(data => data.durations[0][1] || []);
};

const convertSecondsToHoursMins = (seconds) => {
  const hours = Math.floor(seconds / 3600);
  const remainingSeconds = seconds % 3600;
  let minutes = Math.round(remainingSeconds / 60);
  if (minutes < 10) {
    minutes = '0' + minutes;
  };
  return (seconds >= 3600) ? `${hours}h${minutes}` : `${minutes}min`;
}

  const basecampsActivitiesContainer = document.querySelector('.basecamps-activities-container');
  if (basecampsActivitiesContainer === null) {
    return
  }
  const orsApiKey = basecampsActivitiesContainer.dataset.orsApiKey

  const cards = document.querySelectorAll('.card-basecamp-activity');

  cards.forEach((card) => {
    const coords = JSON.parse(card.querySelector('.card-content').dataset.coords);
    const drivingTimePromise = fetchDrivingTime(coords.ori_lat, coords.ori_long, coords.desti_lat, coords.desti_long, orsApiKey);
    drivingTimePromise.then((drivingTime) => {
      const drivingTimeFormatted = convertSecondsToHoursMins(drivingTime);
      addDrivingTimeToCard(card, drivingTimeFormatted);
    });
  });
};

export default initDrivingTimeOnTrips;
