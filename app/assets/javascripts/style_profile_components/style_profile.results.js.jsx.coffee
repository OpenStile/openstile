@StyleProfile.Results = React.createClass
  getInitialState: ->
    profiles: this.props.profiles
    displayProfiles: this.props.profiles
    lastFilterHandler: null

  getStatus: (data) ->
    status = "unopened"
    if data.sessions.length > 0
      status = "opened"
    if (data.sessions.filter (s) -> s.completed).length > 0
      status = "completed"
    if !!data.profile.retailer_matches
      status = "matched"
    if data.profile.match_email_sent?
      status = "matches sent"
    return status

  filterAll: ->
    @setState displayProfiles: @state.profiles, lastFilterHandler: @filterAll

  filterIncomplete: ->
    @setState displayProfiles: (@state.profiles.filter (p) => ['unopened', 'opened'].includes(@getStatus(p))), lastFilterHandler: @filterIncomplete

  filterNeedsMatch: ->
    @setState displayProfiles: (@state.profiles.filter (p) => @getStatus(p) == 'completed'), lastFilterHandler: @filterNeedsMatch

  filterNeedsMatchEmail: ->
    @setState displayProfiles: (@state.profiles.filter (p) => @getStatus(p) == 'matched'), lastFilterHandler: @filterNeedsMatchEmail

  handleRetailerMatchUpdate: (profile_id, match_string) ->
    $.post '/swipe_styles/update_matches',
      profile_id: profile_id
      match_string: match_string
      (data) =>
        profiles = @state.profiles.slice()
        idx = profiles.indexOf((profiles.filter (d) -> d.profile.id == data.updated_profile.id)[0])
        profiles[idx].profile = data.updated_profile
        @setState(profiles: profiles, @state.lastFilterHandler)

  render: ->
    profiles = (`<Profile key={data.profile.id} {...data} status={this.getStatus(data)} onRetailerMatch={this.handleRetailerMatchUpdate}/>` for data in @state.displayProfiles)
    `<div>
      <div className="row text-center filters">
        <div className="btn-group">
          <button type="button" className="btn btn-default" onClick={this.filterAll}>All</button>
          <button type="button" className="btn btn-default" onClick={this.filterIncomplete}>Incomplete</button>
          <button type="button" className="btn btn-default" onClick={this.filterNeedsMatch}>Needs Match</button>
          <button type="button" className="btn btn-default" onClick={this.filterNeedsMatchEmail}>Needs Match Email</button>
        </div>
      </div>
      {profiles}
    </div>`

Profile = React.createClass
  getInitialState: ->
    likesModalOpen: false

  componentWillMount: ->
    ReactModal.setAppElement('.style-page')

  profileCompleted: ->
    !["opened", "unopened"].includes(this.props.status)

  openLikesModal: ->
    @setState likesModalOpen: true

  closeLikesModal: ->
    @setState likesModalOpen: false

  render: ->
    statusClassMap =
      "unopened": "label-default"
      "opened": "label-warning"
      "completed": "label-primary"
      "matched": "label-primary"
      "matches sent": "label-success"
    images = (`<img key={index} className="col-xs-3 img-responsive" src={like} style={{width: 200, height: 250}}></img>` for like, index in @props.likes)
    `<div className="row profile">
      <div className="col-sm-3">
        <p><span className={'label ' + statusClassMap[this.props.status]}>{this.props.status}</span></p>
        <p>Name: {this.props.profile.first_name} {this.props.profile.last_name}</p>
        <p>Email: {this.props.profile.email}</p>
      </div>
      <div className="col-sm-3 text-center">
        {this.profileCompleted() &&
          <div className="cell-contents">
            <p><button type="button" className="btn btn-default" onClick={this.openLikesModal} style={{width: '140px'}}>View liked styles</button></p>
            <p><button type="button" className="btn btn-default" style={{width: '140px'}}>View style info</button></p>
          </div>
        }
      </div>
      <div className="col-sm-6">
        {this.profileCompleted() &&
          <div className="cell-contents input-group">
            <input ref="matches" type="text" className="form-control" defaultValue={this.props.profile.retailer_matches} placeholder="Boutique 1, Boutique 2, ..." />
            <span className="input-group-btn">
              <button className="btn btn-success" onClick={this.updateRetailerMatches}>Update</button>
            </span>
          </div>
        }
        {this.props.status == "matched" &&
          <button className="btn btn-success pull-right" onClick={this.sendMatches}>Send match email</button>
        }
      </div>
      <ReactModal
        isOpen={this.state.likesModalOpen}
        onRequestClose={this.closeLikesModal}
        style={{overlay: {backgroundColor: 'rgba(0, 0, 0, 0.75)', zIndex: 99}}}
        contentLabel="Liked Styles">
            <h1>Favorite Styles</h1>
            <div className="row">
              {images}
            </div>
      </ReactModal>
    </div>`

  updateRetailerMatches: ->
    @props.onRetailerMatch(@props.profile.id, @refs.matches.value)

  sendMatches: ->
    console.log("In progress")
