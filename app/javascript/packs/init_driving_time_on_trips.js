
const initDrivingTimeOnTrips = () => {

const addDrivingTimeToCard = (card, drivingTime) => {
    card.querySelector('#driving-time').insertAdjacentHTML('beforeEnd', `<i class="fas fa-car"></i> ${drivingTime}`);
};

const fetchDrivingTime = (ori_lat, ori_long, desti_lat, desti_long) => {
  const apiKey='5b3ce3597851110001cf624811f828bf686741448a9ed982b4169a87'
  const url = `https://api.openrouteservice.org/matrix?api_key=${apiKey}&profile=driving-car&locations=${ori_long},${ori_lat}%7C${desti_long},${desti_lat}`;
  return fetch(url).then(response => response.json()).then(data => data.durations[0][1] || []);
};

const convertSecondsToHoursMins = (seconds) => {
  const hours = Math.floor(seconds / 3600);
  const remainingSeconds = seconds % 3600;
  const minutes = Math.round(remainingSeconds / 60);
  return (seconds >= 3600) ? `${hours}h${minutes}` : `${minutes}min`;
}

  const cards = document.querySelectorAll('.card-basecamp-activity');

  cards.forEach((card) => {
    const cardContent = card.querySelector('.card-content');
    const coords = JSON.parse(cardContent.dataset.coords);
    console.log(coords);
    let drivingTimePromise = fetchDrivingTime(coords.ori_lat, coords.ori_long, coords.desti_lat, coords.desti_long);
    drivingTimePromise.then((drivingTime) => {
      const drivingTimeFormatted = convertSecondsToHoursMins(drivingTime)
      addDrivingTimeToCard(card, drivingTimeFormatted);
    });
  });
};

export default initDrivingTimeOnTrips;
