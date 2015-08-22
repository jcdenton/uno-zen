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

    relaxing = false
    player = undefined

    $('#relax-button').click ->
      $('#relax-button').hide()
      $('#enough-button').show()

      if (!relaxing)
        relaxing = true
        $('<video autoplay loop><source src="/assets/video/belzen_relax.mp4"}}" type="video/mp4"></video>')
          .prependTo 'body'
        player = new YT.Player('relax-player', {
          height: '0',
          width: '0',
          videoId: 'GeB2UKGUgqQ',
          playerVars: {
            autoplay: true,
            loop: true,
          },
        })
      else
        player.playVideo()

    $('#enough-button').click ->
      player.pauseVideo()
      $('#enough-button').hide()
      $('#relax-button').show()
