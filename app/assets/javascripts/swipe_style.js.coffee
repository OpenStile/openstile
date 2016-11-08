class @InterestSwiperQuiz
  init: () ->
    $(".swipe-stile .thank-you").hide()
    dislikeFunction = (item) ->
      if(item.index() == 0)
        InterestSwiperQuiz.finalizeQuiz($(item).data('session_id'))
    likeFunction = (item) ->
      InterestSwiperQuiz.setLike($(item).data('session_id'), $(item).data('style_id'))
      if(item.index() == 0)
        InterestSwiperQuiz.finalizeQuiz($(item).data('session_id'))
    $('#tinderslide').jTinder(
      onDislike: dislikeFunction
      onLike: likeFunction
      animationRevertSpeed: 200
      animationSpeed: 400,
      threshold: 1,
      likeSelector: '.like'
      dislikeSelector: '.dislike'
    )
    InterestSwiperQuiz.registerEvents()

  @registerEvents: () ->
    $('#hate-btn').click ->
      $("#tinderslide").jTinder('dislike')

    $('#like-btn').click ->
      $("#tinderslide").jTinder('like')

  @finalizeQuiz: (session_id) ->
    InterestSwiperQuiz.completeQuiz(session_id)
    $(".swipe-stile .wrap").hide()
    $(".swipe-stile .actions").hide()
    $(".swipe-stile .thank-you").show()

  @setLike: (session_id, like_id) ->
    $.post( "/swipe_styles/like", { session_id: session_id, style_id: like_id } )

  @completeQuiz: (session_id) ->
    $.post( "/swipe_styles/complete", { session_id: session_id } )
