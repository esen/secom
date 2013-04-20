Secom.Views.Lessons ||= {}

class Secom.Views.Lessons.ShowView extends Backbone.View
  template: JST["backbone/templates/lessons/show"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
