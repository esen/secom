Secom.Views.Levels ||= {}

class Secom.Views.Levels.ShowView extends Backbone.View
  template: JST["backbone/templates/levels/show"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    if (confirm('Киреше өчүрүлсүнбү?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
