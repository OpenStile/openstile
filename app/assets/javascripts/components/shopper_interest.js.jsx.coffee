@ShopperInterest = React.createClass
  getInitialState: ->
    missingFields: false
    invalidEmail: false
    saveErrors: null

  validateElements: (emailElement, firstNameElement, lastNameElement) ->
    regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
    emailInvalid = !regex.test(emailElement.value)
    fieldsMissing = false

    if emailElement.value == '' || emailInvalid
      $(emailElement).addClass('error')
      fieldsMissing = true
    else
      $(emailElement).removeClass('error')
    if firstNameElement.value == ''
      $(firstNameElement).addClass('error')
      fieldsMissing = true
    else
      $(firstNameElement).removeClass('error')
    if lastNameElement.value == ''
      $(lastNameElement).addClass('error')
      fieldsMissing = true
    else
      $(lastNameElement).removeClass('error')

    @setState missingFields: fieldsMissing
    @setState invalidEmail: emailInvalid

    return !emailInvalid && !fieldsMissing

  submitInterest: (e) ->
    e.preventDefault()
    result = @validateElements(@refs.email, @refs.first_name, @refs.last_name)
    @sendConfirmation(@refs.email.value, @refs.first_name.value, @refs.last_name.value) if result

  sendConfirmation: (email, first_name, last_name) ->
    $.ajax
      url: "/swipe_styles/invite"
      method: "POST"
      data: JSON.stringify {first_name: first_name, last_name: last_name, email: email}
      dataType: "json"
      contentType: "application/json"
      success: (result) =>
        if result.status == 'ok'
          window.location.href = "/join_confirmation"
        else
          @setState saveErrors: result.message
      error: (result) =>
        @setState invalidEmail: true

  render: ->
    missingFieldsClass = if @state.missingFields then '' else 'hidden'
    invalidEmailClass = if @state.invalidEmail then '' else 'hidden'
    saveErrorClass = if @state.saveErrors? then '' else 'hidden'
    `<div className="mc-interest-form">
        <div className={"validation-errors text-center " + missingFieldsClass}>
            <h3>oops!</h3>
            <h4>Please fill out all fields</h4>
        </div>
        <div className={"validation-errors text-center " + saveErrorClass}>
            <h3>oops!</h3>
            <h4>{this.state.saveErrors}</h4>
        </div>
        <form>
          <div className="mc-field-group form-group">
            <input type="text" placeholder="First Name" ref="first_name" className="form-control"/>
          </div>
          <div className="mc-field-group form-group">
            <input type="text" placeholder="Last Name" ref="last_name" className="form-control"/>
          </div>
          <div className="mc-field-group form-group">
            <input type="text" placeholder="Email" ref="email" className="form-control"/>
          </div>
          <div className={"validation-errors text-center " + invalidEmailClass}>
            <h4>**please enter valid email address</h4>
          </div>
          <div className="form-group">
            <button className="btn btn-lg col-xs-6 col-xs-offset-6 col-sm-4 col-sm-offset-8" onClick={this.submitInterest}>Submit</button>
          </div>
        </form>
    </div>`