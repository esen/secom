Secom.Views.Tests ||= {}

class Secom.Views.Tests.TestView extends Backbone.View
  template: JST["backbone/templates/tests/test"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Өчсүнбү?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
