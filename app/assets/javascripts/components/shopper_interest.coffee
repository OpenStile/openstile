@ShopperInterest = React.createClass
  getInitialState: ->
    missingFields: false
    invalidEmail: false

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
    @refs.form.submit() if result

  render: ->
    missingFieldsClass = if @state.missingFields then '' else 'hidden'
    invalidEmailClass = if @state.invalidEmail then '' else 'hidden'
    React.DOM.div
      className: "mc-interest-form"
      React.DOM.div
        className: "validation-errors text-center " + missingFieldsClass
        React.DOM.h3 null, "oops!"
        React.DOM.h4 null, "Please fill out all fields"
      React.DOM.form
        action: "//openstile.us8.list-manage.com/subscribe/post?u=1523c02fd1f5720ce8e15cb7e&amp;id=4a2a55bb37"
        method: "post"
        target: "blank"
        ref: "form"
        React.DOM.div
          className: "mc-field-group form-group"
          React.DOM.input
            type: "text"
            name: "FNAME"
            id: "mce-FNAME"
            placeholder: "First Name"
            className: "form-control"
            ref: "first_name"
        React.DOM.div
          className: "mc-field-group form-group"
          React.DOM.input
            type: "text"
            name: "LNAME"
            id: "mce-LNAME"
            placeholder: "Last Name"
            className: "form-control"
            ref: "last_name"
        React.DOM.div
          className: "mc-field-group form-group"
          React.DOM.input
            type: "text"
            name: "EMAIL"
            id: "mce-EMAIL"
            placeholder: "Email"
            className: "form-control"
            ref: "email"
        React.DOM.div
          style: {position: 'absolute', left: '-5000px'}
          ariaHidden: "true"
          React.DOM.input
            type: "text"
            name: "b_1523c02fd1f5720ce8e15cb7e_4a2a55bb37"
            tabindex: "-1"
            value: ""
        React.DOM.div
          className: "validation-errors text-center " + invalidEmailClass
          React.DOM.h4 null, "**please enter valid email address"
        React.DOM.div
          className: "form-group"
          React.DOM.button
            className: "btn btn-lg col-xs-6 col-xs-offset-6 col-sm-4 col-sm-offset-8"
            onClick: @submitInterest
            "Submit"