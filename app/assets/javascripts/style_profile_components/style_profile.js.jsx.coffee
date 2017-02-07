@StyleProfile = React.createClass
  getInitialState: ->
    body: null

  componentDidMount: ->
    @setState {body: @styleFormIntro()}

  styleFormIntro: ->
    return `<div className="swipe-intro col-xs-8 col-xs-offset-2 text-center">
      <h3>Swipe us your style!</h3>
      <h4>Click or swipe right for styles you love or click or swipe left for the styles you don't.</h4>
      <button className="btn btn-lg btn-primary" onClick={this.loadSwiperQuiz}>Got it</button>
    </div>`

  loadSwiperQuiz: ->
    @setState {body: `<StyleProfile.Swiper sessionId={this.props.sessionId} swiperStyles={this.props.swiperStyles} loadStyleNeeds={this.loadStyleNeeds}/>`}

  loadStyleNeeds: ->
    @setState {body: `<div className="col-xs-12 col-md-8 col-md-offset-2 text-center">
        <iframe src="https://docs.google.com/forms/d/e/1FAIpQLSfxY4fGn8auoOZwBR2VRiEpjOQT-pmss_WDm-k5lykRl-aJGQ/viewform?embedded=true" width="100%" height="500" frameborder="0" marginheight="0" marginwidth="0">Loading...</iframe></div>`}

  render: ->
    `<div>
      {this.state.body}
    </div>`