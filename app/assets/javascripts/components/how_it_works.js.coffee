@HowItWorks = React.createClass
  render: ->
    React.DOM.div
      className: 'how-it-works row'
      React.createElement HowItWorksStep, iconPath: 'survey.jpg', blurb: 'Create a personalized style profile to capture your unique style preferences.'
      React.createElement HowItWorksStep, iconPath: 'boutique.jpg', blurb: 'Discover neighborhood fashion boutiques and learn about their story, values, and owners.'
      React.createElement HowItWorksStep, iconPath: 'dress.jpg', blurb: 'Book FREE styling sessions. Walk in to find hand-picked items for your shape, size, budget, and more.'