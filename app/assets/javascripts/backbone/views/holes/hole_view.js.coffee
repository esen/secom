Secom.Views.Holes ||= {}

class Secom.Views.Holes.HoleView extends Backbone.View
  template: JST["backbone/templates/holes/hole"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Чыгаша булагы өчсүнбү?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
