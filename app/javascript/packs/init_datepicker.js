const initDatepicker = () => {
  document.addEventListener('DOMContentLoaded', function() {
    const options = {
        firstDay: 1,
        format: 'ddd dd mmmm yyyy',
        autoClose: true,
        i18n: {
          cancel: 'Annuler',
          clear: 'Clear',
          done: 'Ok',
          months: [ 'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre' ],
          monthsShort: [ 'Jan', 'Fev', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Aou', 'Sep', 'Oct', 'Nov', 'Dec' ],
          weekdaysFull: [ 'Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi' ],
          weekdaysShort: [ 'Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam' ],
          today: 'Aujourd\'hui',
          clear: 'Effacer',
          close: 'Fermer',
          labelMonthNext:"Mois suivant",
          labelMonthPrev:"Mois précédent",
          labelMonthSelect:"Sélectionner un mois",
          labelYearSelect:"Sélectionner une année",
          weekdaysAbbrev: ['D','L','M','M','J','V','S']
        }
    };
    const elems = document.querySelectorAll('.datepicker');
    const instances = M.Datepicker.init(elems, options);
  });
};

export default initDatepicker;
