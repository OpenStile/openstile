@HowItWorksStep = React.createClass
  getInitialState: ->
    iconPath: @props.iconPath
    blurb: @props.blurb
  getDefaultProps: ->
    iconPath: ''
    blurb: ''
  render: ->
    React.DOM.div
      className: 'step col-xs-12 col-sm-4'
      React.DOM.a
        href: '/experience'
        React.DOM.img
          className: 'img-responsive center-block'
          src: '/assets/' + @state.iconPath
      React.DOM.h3
        @state.blurb