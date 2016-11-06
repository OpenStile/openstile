class @InterestSwiperQuiz
  init: () ->
    $(".swipe-stile .thank-you").hide()
    dislikeFunction = (item) ->
      console.log('Dislike image '+ (item.index()))
      if(item.index() == 0)
        InterestSwiperQuiz.finalizeQuiz()
    likeFunction = (item) ->
      console.log('Like image '+ (item.index()))
      if(item.index() == 0)
        InterestSwiperQuiz.finalizeQuiz()
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

  @finalizeQuiz: () ->
    console.log('called')
    $(".swipe-stile .wrap").hide()
    $(".swipe-stile .actions").hide()
    $(".swipe-stile .thank-you").show()
