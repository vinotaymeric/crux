if ($('#infinite-scrolling').size() > 0) {
  console.log('fdsjkflsd')
  $(window).on('scroll', function() {
    var more_itineraries_url = $('.pagination .next_page a').attr('href');
    
    if (more_itineraries_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
      $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
      $.getScript(more_itineraries_url);
    }
  });
}