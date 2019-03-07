if ($('#infinite-scrolling').size() > 0) {
  $(window).on('scroll', function() {
    var more_itineraries_url = $('.pagination .next_page a').attr('href');
    console.log(more_itineraries_url);
    if (more_itineraries_url && $(window).scrollTop() > ($(document).height() - $(window).height() - 60)) {
      $('.pagination ').html('<div id="gifDelimiter"><img src="https://res.cloudinary.com/deesjjv4h/image/upload/v1551982386/crux/images/ajax-loader.gif"  alt="Loading..." title="Loading..." /></div>')
      $.getScript(more_itineraries_url);
    }
  });
}

