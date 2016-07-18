@Retailer = React.createClass
  getInitialState: ->
    retailer: @props.data
  getDefaultProps: ->
    retailer: {}
  render: ->
    React.DOM.div
      className: 'retailer'
      React.DOM.a
        href: @state.retailer.pageLink
        React.DOM.h2
          className: 'title text-center', @state.retailer.name
      React.DOM.h3
        className: 'address text-center', @state.retailer.neighborhood + ', ' + @state.retailer.city