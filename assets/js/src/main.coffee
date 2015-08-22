'use strict'

$ ->

  el = document.body
  el.dataset.page = Uno.context()
  el.dataset.device = Uno.device()
  $(window).on "resize", Uno.device()
  $(window).on "orientationchange", Uno.device()

  Uno.readTime()
  FastClick.attach el unless Uno.is 'device', 'desktop'

  $('#profile-title').text window.profile_title if window.profile_title
  $('#profile-resume').text window.profile_resume if window.profile_resume

  if Uno.is 'device', 'desktop'
    $(document.links).filter ->
      @hostname != window.location.hostname
    .attr 'target', '_blank'

  if Uno.is 'page', 'post'
    $('main').readingTime readingTimeTarget: '.post.reading-time > span'
    $('.content').fitVids()

  if Uno.is 'page', 'error'
    $('#panic-button').click ->
      location.reload()
    $('#relax-button').click ->
      $('<video autoplay="" loop="" style="visibility: visible; margin: auto; position: absolute; z-index: -1; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 1207px; height: auto;">
           <source src="http://belzen.by/resources/themes/belzen_relax.mp4" type="video/mp4">
           <source src="http://belzen.by/resources/themes/belzen_relax.webm" type="video/webm">
           <source src="http://belzen.by/resources/themes/belzen_relax.ogv" type="video/ogg">
         </video>').prependTo 'body'
