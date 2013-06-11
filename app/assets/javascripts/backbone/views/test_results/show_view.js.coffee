Secom.Views.TestResults ||= {}

class Secom.Views.TestResults.ShowView extends Backbone.View
  template: JST["backbone/templates/test_results/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
