const initDatepicker = () => {
  document.addEventListener('DOMContentLoaded', function() {
    const elems = document.querySelectorAll('.datepicker');
    const options = {
        firstDay: 1,
        format: 'dd mmmm yyyy',
        formatSubmit: 'yyyy/mm/dd',
        i18n: {
          cancel: 'Annuler',
          clear: 'Clear',
          done: 'Ok',
          months: [
                    'Janvier',
                    'Février',
                    'Mars',
                    'Avril',
                    'Mai',
                    'Juin',
                    'Juillet',
                    'Août',
                    'Septembre',
                    'Octobre',
                    'Novembre',
                    'Décembre'
                  ],
          monthsShort: [
                        'Jan',
                        'Fev',
                        'Mars',
                        'Avr',
                        'Mai',
                        'Juin',
                        'Juil',
                        'Août',
                        'Sept',
                        'Oct',
                        'Nov',
                        'Déc'
                      ],
          weekdaysShort:
                        [
                          'Dim',
                          'Lun',
                          'Mar',
                          'Mer',
                          'Jeu',
                          'Ven',
                          'Sam'
                        ],
          weekdaysAbbrev: ['D','L','M','M','J','V','S']
        }
    };
    const instances = M.Datepicker.init(elems, options);
  });
};

export default initDatepicker;
