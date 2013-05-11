Secom.Views.Sources ||= {}

class Secom.Views.Sources.ShowView extends Backbone.View
  template: JST["backbone/templates/sources/show"]

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
