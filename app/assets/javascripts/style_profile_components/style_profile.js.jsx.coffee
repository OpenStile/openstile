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

  styleFormOutro: ->
    return `<div className="swipe-intro col-xs-8 col-xs-offset-2 text-center">
      <h3>Thank you for your creating your profile!</h3>
      <h4>We will be sending you your matches by email shortly. Until then, check out the latest on the <a href="http://blog.openstile.com">blog</a></h4>
    </div>`

  loadSwiperQuiz: ->
    @setState {body: `<StyleProfile.Swiper sessionId={this.props.sessionId} swiperStyles={this.props.swiperStyles} loadStyleNeeds={this.loadStyleNeeds}/>`}

  loadStyleNeeds: ->
    @setState body: `<StyleProfile.NeedsForm profileId={this.props.profileId} {...this.props.bodyTypeImages} onSubmit={this.finalizeQuiz}/>`

  finalizeQuiz: ->
    @setState body: @styleFormOutro()

  render: ->
    `<div>
      {this.state.body}
    </div>`