Secom.Views.TestResults ||= {}

class Secom.Views.TestResults.TestResultView extends Backbone.View
  template: JST["backbone/templates/test_results/test_result"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
