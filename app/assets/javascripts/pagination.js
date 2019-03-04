if ($('#infinite-scrolling').size() > 0) {
  $(window).on('scroll', function() {
    var more_itineraries_url = $('.pagination .next_page a').attr('href');
    console.log(more_itineraries_url);
    if (more_itineraries_url && $(window).scrollTop() > ($(document).height() - $(window).height() - 60)) {
      $('#infinite-scrolling .pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
      $.getScript(more_itineraries_url);
    }
  });
}

