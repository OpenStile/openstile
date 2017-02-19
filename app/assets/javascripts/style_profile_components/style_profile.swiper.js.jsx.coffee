@StyleProfile.Swiper = React.createClass
  getInitialState: ->
    imagesLoaded: false

  generateImageCSS: (styleItem) ->
    return {
      background: "url('" + styleItem.image + "') no-repeat scroll center center"
      backgroundSize: 'cover'
    }

  initializeLibrary: () ->
    $(@refs.swiper).jTinder(
      onDislike: @itemDislike
      onLike: @itemLike
      animationRevertSpeed: 200
      animationSpeed: 400
      threshold: 1
    )

  increaseCount: () ->
    @completeCount = @completeCount || 1
    @completeCount += 1
    @completeQuiz() if @completeCount == 25

  completeQuiz: () ->
    $.post("/swipe_styles/complete", {session_id: @props.sessionId, like_ids: @likedIds}).done(=> @props.loadStyleNeeds())

  itemLike: (id) ->
    @likedIds = @likedIds || []
    @likedIds.push($(id).data("id"))
    @increaseCount()

  itemDislike: () ->
    @increaseCount()

  likeButtonAction: () ->
    $(@refs.swiper).jTinder('like')

  dislikeButtonAction: () ->
    $(@refs.swiper).jTinder('dislike')

  componentDidMount: ->
    for image in (style.image for style in @props.swiperStyles)
      img = new Image()
      $(img).load(@imageLoaded)
      img.src = image

  componentDidUpdate: ->
    @initializeLibrary()

  imageLoaded: ->
    @imageLoadedCount = @imageLoadedCount || 1
    @imageLoadedCount += 1
    @setState(imagesLoaded: true) if @imageLoadedCount == 25

  generateLoading: ->
    return `<div>
      Loading...
    </div>`

  generateQuiz: ->
    styleItems = for styleItem,index in @props.swiperStyles
      `<li key={styleItem.id} data-id={styleItem.id}>
        <div className="img" style={this.generateImageCSS(styleItem)}></div>
        <div>{styleItem.title}</div>
        <div style={{fontSize: 10, fontStyle: 'italic'}}>{this.props.swiperStyles.length - index} out of {this.props.swiperStyles.length}</div>
      </li>`
    return `<div>
    <div className="wrap">
      <div ref='swiper' id='tinderslide'>
        <ul>
          {styleItems}
        </ul>
      </div>
    </div>
    <div className="row actions">
      <div className="col-xs-6 text-right">
        <button id='hate-btn' className="btn btn-lg" onClick={this.dislikeButtonAction}>Nope</button>
      </div>
      <div className="col-xs-6 text-left">
        <button id='like-btn' className="btn btn-lg" onClick={this.likeButtonAction}>Like</button>
      </div>
    </div>
    </div>`

  render: ->
    if @state.imagesLoaded
      @generateQuiz()
    else
      @generateLoading()
