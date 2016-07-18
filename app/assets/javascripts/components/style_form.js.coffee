@StyleForm = React.createClass
  getInitialState: ->
    top_sizes: @props.data.top_sizes
    bottom_sizes: @props.data.bottom_sizes
    dress_sizes: @props.data.dress_sizes
    token: @props.authenticity_token
  getDefaultProps: ->
    top_sizes: {}
    bottom_sizes: {}
    dress_sizes: {}
  render: ->
    React.DOM.div
      className: 'style-form'
      React.DOM.form
        action: '/style_profiles/quickstart'
        method: 'POST'
        React.DOM.input
          type: 'hidden'
          name: 'authenticity_token'
          value: @state.token
        React.DOM.div
          className: 'form-group'
          React.DOM.label
            for: 'top-sizes', 'Top Sizes'
          React.DOM.select
            id: 'top-sizes'
            name: 'style_profile[top_size_ids]'
            for size in @state.top_sizes
              React.DOM.option
                value: size.value
                label: size.label
          React.DOM.label
            for: 'bottom-sizes', 'Bottom Sizes'
          React.DOM.select
            id: 'bottom-sizes'
            name: 'style_profile[bottom_size_ids]'
            for size in @state.bottom_sizes
              React.DOM.option
                value: size.value
                label: size.label
          React.DOM.label
            for: 'dress-sizes', 'Dress Sizes'
          React.DOM.select
            id: 'dress-sizes'
            name: 'style_profile[dress_size_ids]'
            for size in @state.dress_sizes
              React.DOM.option
                value: size.value
                label: size.label
          React.DOM.button
            type: 'submit'
            className: 'btn btn-primary'
            'Save'