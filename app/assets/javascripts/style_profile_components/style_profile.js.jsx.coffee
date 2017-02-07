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
    window.location.href = "https://goo.gl/forms/GJUMTLxBIqERVjKA2"

  render: ->
    `<div>
      {this.state.body}
    </div>`