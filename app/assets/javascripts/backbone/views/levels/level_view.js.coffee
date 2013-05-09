Secom.Views.Levels ||= {}

class Secom.Views.Levels.LevelView extends Backbone.View
  template: JST["backbone/templates/levels/level"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
