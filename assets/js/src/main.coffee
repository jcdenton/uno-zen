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
      $('body').prepend(
        $('<video autoplay loop><source src="/assets/video/belzen_relax.mp4"}}" type="video/mp4"></video>'),
        $('<iframe width="0" height="0" src="https://www.youtube.com/embed/GeB2UKGUgqQ?autoplay=1&controls=0&loop=1" frameborder="0"></iframe>')
      )
