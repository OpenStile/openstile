@StyleProfile.NeedsForm = React.createClass
  getInitialState: ->
    errors: null

  validate: ->
    valid = true
    if !@refs.zipcode.value
      valid = false
      $(@refs.zipcode).closest(".form-group").addClass("has-error")
    if !$(@refs.body_type_inputs).find("input:checked").val()
      valid = false
      $(@refs.body_type_inputs).closest(".form-group").addClass("has-error")
    if !@refs.height.value
      valid = false
      $(@refs.height).closest(".form-group").addClass("has-error")
    if !@refs.dress_size.value
      valid = false
      $(@refs.dress_size).closest(".form-group").addClass("has-error")
    if !@refs.pants_size.value
      valid = false
      $(@refs.pants_size).closest(".form-group").addClass("has-error")
    return valid

  handleSaveForm: ->
    if @validate()
      data =
        height: @refs.height.value
        body_type: $(@refs.body_type_inputs).find("input:checked").val()
        dress_size: @refs.dress_size.value
        pants_size: @refs.pants_size.value
        demin_size: @refs.denim_size.value
        shirt_size: $(@refs.shirt_size_inputs).find("input:checked").val()
        bra_size: @refs.bra.value
        shoe_size: $(@refs.shoe_size_inputs).find("input:checked").val()
        parts_to_accentuate: (el.value for el in $(@refs.accentuate_inputs).find("input:checked"))
        parts_to_deemphasize: (el.value for el in $(@refs.deemphasize_inputs).find("input:checked"))
        preferred_colors: (el.value for el in $(@refs.preferred_colors).find("input:checked"))
        not_preferred_colors: (el.value for el in $(@refs.not_preferred_inputs).find("input:checked"))
        zipcode: @refs.zipcode.value
        comments: @refs.comments.value
      $.post('/swipe_styles/update_style_needs', {profile_id: @props.profileId, data: data}).done(=> @props.onSubmit())
    else
      @setState errors: "Please enter all required fields"

  render: ->
    `<div className="container">
      <div className="text-center">
        <h4>Now that we have a sense of your style, tell us about your body so our in house boutique style advisors can find your perfect fit</h4>
      </div>
      <div className="form col-sm-6 col-sm-offset-3">
        <div className="form-group">
          <p>What is your height?</p>
          <input ref="height" type="text" className="form-control" placeholder="Height" />
          <span className="help-block">* required</span>
        </div>
        <div ref="body_type_inputs" className="form-group">
          <p>What is your closest body shape?</p>
          <span className="help-block">* required</span>
          <div>
            <label className="radio-inline">
              <input type="radio" name="body_type" value="column" />
              Column
              <img className="img-responsive" src={this.props.column}></img>
            </label>
            <label className="radio-inline">
              <input type="radio" name="body_type" value="apple" />
              Apple
              <img className="img-responsive" src={this.props.apple}></img>
            </label>
          </div>
          <div>
            <label className="radio-inline">
              <input type="radio" name="body_type" value="pear" />
              Pear
              <img className="img-responsive" src={this.props.pear}></img>
            </label>
            <label className="radio-inline">
              <input type="radio" name="body_type" value="hourglass" />
              Hourglass
              <img className="img-responsive" src={this.props.hourglass}></img>
            </label>
          </div>
          <div>
            <label className="radio-inline">
              <input type="radio" name="body_type" value="inverted_triangle" />
              Inverted Triangle
              <img className="img-responsive" src={this.props.inverted_triangle}></img>
            </label>
          </div>
        </div>
        <div className="form-group">
          <p>What is your dress size?</p>
          <span className="help-block">* required</span>
          <select ref="dress_size" class="form-control">
            <option value="">Select one...</option>
            <option value="0">0</option>
            <option value="2">2</option>
            <option value="4">4</option>
            <option value="6">6</option>
            <option value="8">8</option>
            <option value="10">10</option>
            <option value="12">12</option>
            <option value="14+">14+</option>
          </select>
        </div>
        <div className="form-group">
          <p>What is your pants size?</p>
          <span className="help-block">* required</span>
          <select ref="pants_size" class="form-control">
            <option value="">Select one...</option>
            <option value="0">0</option>
            <option value="2">2</option>
            <option value="4">4</option>
            <option value="6">6</option>
            <option value="8">8</option>
            <option value="10">10</option>
            <option value="12">12</option>
            <option value="14+">14+</option>
          </select>
        </div>
        <div className="form-group">
          <p>What is your denim size?</p>
          <select ref="denim_size" class="form-control">
            <option value="">Select one...</option>
            <option value="24">24</option>
            <option value="25">25</option>
            <option value="26">26</option>
            <option value="27">27</option>
            <option value="28">28</option>
            <option value="29">29</option>
            <option value="30">30</option>
            <option value="31">31</option>
          </select>
        </div>
        <div ref="shirt_size_inputs" className="form-group">
          <p>What is your shirt size?</p>
          <div class="radio">
            <label>
              <input type="radio" name="shirt_size" value="XS" />  XS
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="shirt_size" value="S" />  S
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="shirt_size" value="M" />  M
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="shirt_size" value="L" />  L
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="shirt_size" value="XL" />  XL
            </label>
          </div>
        </div>
        <div className="form-group">
          <p>What is your bra size?</p>
          <input ref="bra" type="text" className="form-control" placeholder="Bra Size" />
        </div>
        <div ref="shoe_size_inputs" className="form-group">
          <p>What is your shoe size? (please round up for half sizes)</p>
          <div class="radio">
            <label>
              <input type="radio" name="shoe_size" value="5" />  5
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="shoe_size" value="6" />  6
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="shoe_size" value="7" />  7
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="shoe_size" value="8" />  8
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="shoe_size" value="9" />  9
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="shoe_size" value="10" />  10
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="shoe_size" value="11" />  11
            </label>
          </div>
        </div>
        <div ref="accentuate_inputs" className="form-group">
          <p>What areas do you like to accentuate? </p>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Arms" />  Arms
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Bust" />  Bust
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Waist" />  Waist
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Bottom_Booty" />  Bottom/Booty
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Legs_Full" />  Legs: Full
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Legs_Thighs" />  Legs: Thighs
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Legs_Calves" />  Legs: Calves
            </label>
          </div>
        </div>
        <div ref="deemphasize_inputs" className="form-group">
          <p>What areas do you like to de-emphasize? </p>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Arms" />  Arms
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Bust" />  Bust
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Waist" />  Waist
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Bottom_Booty" />  Bottom/Booty
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Legs_Full" />  Legs: Full
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Legs_Thighs" />  Legs: Thighs
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Legs_Calves" />  Legs: Calves
            </label>
          </div>
        </div>
        <div ref="preferred_colors" className="form-group">
          <p>What kind of colors do you generally prefer? </p>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Black" />  Black
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Gray" />  Gray
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="White" />  White
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Neutrals" />  Neutrals
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Orange" />  Orange
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Yellow" />  Yellow
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Green" />  Green
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Blue" />  Blue
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Red" />  Red
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Purple" />  Purple
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Pink" />  Pink
            </label>
          </div>
        </div>
        <div ref="not_preferred_inputs" className="form-group">
          <p>What kind of colors do you generally not prefer? </p>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Black" />  Black
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Gray" />  Gray
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="White" />  White
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Neutrals" />  Neutrals
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Orange" />  Orange
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Yellow" />  Yellow
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Green" />  Green
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Blue" />  Blue
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Red" />  Red
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Purple" />  Purple
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" value="Pink" />  Pink
            </label>
          </div>
        </div>
        <div className="form-group">
          <p>Additional comments</p>
          <textarea ref="comments" className="form-control" />
        </div>
        <div className="form-group">
          <p>Where in NYC do you reside (zip code)?</p>
          <input ref="zipcode" type="text" className="form-control" placeholder="Your answer" />
          <span className="help-block">* required</span>
        </div>
        <div>
          <button className="btn btn-default" onClick={this.handleSaveForm}>Submit</button>
        </div>
      </div>
    </div>`
