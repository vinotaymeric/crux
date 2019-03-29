const initDatepicker = () => {
  function getNextDayOfWeek(date, dayOfWeek) {
    const resultDate = new Date(date.getTime());
    resultDate.setDate(date.getDate() + (7 + dayOfWeek - date.getDay()) % 7);
    return resultDate;
  }

  function capital_letter_remove_points(str) {
    str = str.split(".");
    str = str.join("");
    str = str.split(" ");
    for (var i = 0, x = str.length; i < x; i++) {
        str[i] = str[i][0].toUpperCase() + str[i].substr(1);
    }
    return str.join(" ");
  }

  document.addEventListener('DOMContentLoaded', function() {
    const today = new Date();
    const nextSaturday = getNextDayOfWeek(today, 6);
    var afterTwoWeeks = new Date(+new Date + 12096e5);
    const options = {
        firstDay: 1,
        format: 'ddd dd mmmm yyyy',
        autoClose: true,
        minDate: today,
        maxDate: afterTwoWeeks,
        defaultDate: nextSaturday,
        setDefaultDate: false,
        onSelect: function(returned_date){
          if (this.el.classList.contains("datepicker-end")) {
            return;
          }
          const pickerEnd = document.querySelector(".datepicker-end");
          const instance = M.Datepicker.getInstance(pickerEnd);

          instance.setDate(returned_date);
          instance.options.minDate = returned_date;
          // set placeholder to end date
          const options = { weekday: 'short', year: 'numeric', month: 'long', day: '2-digit' };
          pickerEnd.value = capital_letter_remove_points(returned_date.toLocaleDateString('fr-FR', options));
        },
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



