'use strict'

$ ->

  el = document.body
  el.dataset.page = Uno.context()
  el.dataset.device = Uno.device()

  Uno.readTime()
  FastClick.attach el unless Uno.is 'device', 'desktop'

  $('#profile-title').text window.profile_title if window.profile_title
  $('#profile-resume').text window.profile_resume if window.profile_resume

  if Uno.is 'device', 'desktop'
    $('a').not('[href*="mailto:"]').click ->
      if this.href.indexOf(location.hostname) is -1
        window.open $(this).attr 'href'
        false

  if Uno.is 'page', 'post'
    $('main').readingTime readingTimeTarget: '.post.reading-time > span'
    $('.content').fitVids()

  if Uno.is 'page', 'error'
    $('#panic-button').click (e) ->
      e.preventDefault()
      location.reload()

    relaxing = false
    player = undefined

    $('#relax-button').click (e) ->
      e.preventDefault()

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
          playerVars:
            autoplay: false,
            loop: true
          events:
            onReady: (e) ->
              player.setVolume(player.getVolume() / 2)
              player.playVideo()
        })
      else
        player.playVideo()

    $('#enough-button').click (e) ->
      e.preventDefault()
      player.pauseVideo()
      $('#enough-button').hide()
      $('#relax-button').show()
