@ShareQuiz = React.createClass
  getInitialState: ->
    round: 1
    remainingCategorizations: Object.keys(@props.categorizations)
    winner: null

  handleCompleteRound: (winners) ->
    categorizations = @state.remainingCategorizations.slice()
    categorizations = (categorizations.filter (c) -> winners.includes(c))
    if categorizations.length == 1
      @setState remainingCategorizations: [], winner: categorizations[0]
    else
      @setState remainingCategorizations: categorizations, round: @state.round + 1

  render: ->
    unmatched = @state.remainingCategorizations.slice()
    matchups = []
    while unmatched.length > 0
      newMatch = unmatched.slice(0,2)
      unmatched = unmatched.slice(2)
      matchup =
        option1:
          name: newMatch[0],
          image: @props.categorizations[newMatch[0]][this.state.round - 1]
        option3:
          name: newMatch[0],
          image: @props.categorizations[newMatch[0]][this.state.round]
      if newMatch.length > 1
        matchup.option2 = {name: newMatch[1], image: @props.categorizations[newMatch[1]][this.state.round - 1]}
        matchup.option4 = {name: newMatch[1], image: @props.categorizations[newMatch[1]][this.state.round]}
      matchups.push(matchup)
    round = null
    if matchups.length > 0
      round = `<Round onCompleteRound={this.handleCompleteRound} round={this.state.round} totalRounds={Math.floor(Object.keys(this.props.categorizations).length / 2)} matchups={matchups} />`
    else
      round = `<Result name={this.state.winner} image={this.props.results[this.state.winner].image} description={this.props.results[this.state.winner].description} />`
    `<div className="quiz">
      {round}
    </div>`

Result = React.createClass
  onComponentDidMount: ->
    FB.AppEvents.logEvent("viewedResults");

  shareResults: ->
    FB.AppEvents.logEvent("sharedResults");
    FB.ui(
      display: 'popup',
      method: 'share',
      title: 'My red carpet style is ' + @props.name + '. How about you?',
      description: "What's your red carpet style? Find out now!",
      link: "http://www.openstile.com/share_quizzes/red_carpet_quiz",
      picture: @props.image,
      href: "http://www.openstile.com/share_quizzes/red_carpet_quiz"
    )

  render: ->
    `<div className="row">
      <div className="col-sm-8 col-sm-offset-2">
        <div className="result text-center">
          <img width="100%" src={this.props.image}/>
          <h3>Your red carpet style: <b>{this.props.name}</b></h3>
          <p>{this.props.description}</p>
          <div className="share-button">
            <button ref="share" className="btn btn-lg" onClick={this.shareResults}><i className="fa fa-facebook-official" aria-hidden="true"></i>&#9;Share</button>
          </div>
        </div>
      </div>
    </div>`

Round = React.createClass
  componentWillMount: ->
    @winners = []

  componentWillUpdate: ->
    $(@refs.round).fadeOut(500)
    @winners = []

  componentDidMount: ->
    @fadeIn()

  componentDidUpdate: ->
    @fadeIn()

  fadeIn: ->
    window.scrollTo(0, 0)
    $(@refs.round).fadeIn(2500)

  handleMatchupWinner: (index, winner) ->
    @winners[index] = winner
    if (@winners.filter (x) -> x?).length == @props.matchups.length
      @props.onCompleteRound(@winners)

  render: ->
    matchups = []
    for matchup, index in @props.matchups
      if matchup.option2?
        matchups.push(`<Matchup key={matchup.option1.name + '.' + matchup.option2.name} {...matchup} matchIndex={index} updateWinner={this.handleMatchupWinner}/>`)
      else
        @handleMatchupWinner(index, matchup.option1.name)
    `<div ref="round">
        <h4>For each of the following, choose which style you like best (<span style={{fontSize: '14px'}}>Round {this.props.round} out of {this.props.totalRounds}</span>)</h4>
        {matchups}
    </div>`

Matchup = React.createClass
  handleWinner: (e) ->
    @props.updateWinner(@props.matchIndex, e.target.value)

  getSizedImage: (url) ->
    sized = url
    if $(window).width() < 768
      sized = sized.replace("c_thumb,h_324,w_250", "c_thumb,h_129,w_100")
    else if $(window).width() < 992
      sized = sized.replace("c_thumb,h_324,w_250", "c_thumb,h_259,w_200")
    return sized

  render: ->
    `<div className="row">
      <div className="col-sm-10 col-sm-offset-1">
        <div className="form-group">
          <label className="radio-inline">
            <input type="radio" name={"match." + this.props.matchIndex} value={this.props.option1.name} onChange={this.handleWinner} />
            <img className="img-responsive" src={this.getSizedImage(this.props.option1.image)}></img>
          </label>
          <label className="radio-inline">
            <input type="radio" name={"match." + this.props.matchIndex} value={this.props.option2.name} onChange={this.handleWinner} />
            <img className="img-responsive" src={this.getSizedImage(this.props.option2.image)}></img>
          </label>
        </div>
      </div>
      <div className="col-sm-10 col-sm-offset-1">
        <div className="form-group">
          <label className="radio-inline">
            <input type="radio" name={"match." + this.props.matchIndex} value={this.props.option3.name} onChange={this.handleWinner} />
            <img className="img-responsive" src={this.getSizedImage(this.props.option3.image)}></img>
          </label>
          <label className="radio-inline">
            <input type="radio" name={"match." + this.props.matchIndex} value={this.props.option4.name} onChange={this.handleWinner} />
            <img className="img-responsive" src={this.getSizedImage(this.props.option4.image)}></img>
          </label>
        </div>
        <hr />
      </div>
    </div>`