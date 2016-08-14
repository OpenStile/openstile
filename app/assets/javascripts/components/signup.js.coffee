@Signup = React.createClass
  getInitialState: ->
    errors: []

  updateErrors: (data) ->
    @replaceState errors: data

  createUser: (e) ->
    e.preventDefault()

    $.ajax
      method: 'POST'
      url: '/users'
      dataType: 'JSON'
      data:
        user:
          first_name: @refs.first_name.value
          last_name: @refs.last_name.value
          email: @refs.email.value
          password: @refs.password.value
          password_confirmation: @refs.password.value
      success: (data) =>
        window.location = data.location
      error: (jqXHR, textStatus, errorThrown) =>
        @updateErrors(jqXHR.responseJSON)

  render: ->
    error_list = []
    error_list.push(React.DOM.h4(null, error)) for error in @state.errors
    React.DOM.form
      className: 'signup-form'
      React.DOM.div
        className: 'form-errors text-center'
        error_list
      React.DOM.div
        className: 'row form-group'
        React.DOM.div
          className: 'col-xs-6'
          React.DOM.div
            className: 'col-xs-12'
            React.DOM.input
              className: 'form-control'
              placeholder: 'First Name'
              type: 'text'
              ref: 'first_name'
        React.DOM.div
          className: 'col-xs-6'
          React.DOM.div
            className: 'col-xs-12'
            React.DOM.input
              className: 'form-control'
              placeholder: 'Last Name'
              type: 'text'
              ref: 'last_name'
      React.DOM.div
        className: 'row form-group'
        React.DOM.div
          className: 'col-xs-6'
          React.DOM.div
            className: 'col-xs-12'
            React.DOM.input
              className: 'form-control'
              placeholder: 'Email'
              type: 'text'
              ref: 'email'
        React.DOM.div
          className: 'col-xs-6'
          React.DOM.div
            className: 'col-xs-12'
            React.DOM.input
              className: 'form-control'
              placeholder: 'Password'
              type: 'password'
              ref: 'password'
      React.DOM.div
        className: 'row form-group'
        React.DOM.div
          className: 'col-xs-6 col-xs-offset-6'
          React.DOM.button
            className: 'btn btn-lg btn-default col-xs-7 col-xs-offset-4'
            onClick: @createUser
            'Submit'
