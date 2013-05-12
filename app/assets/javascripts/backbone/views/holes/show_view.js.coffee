Secom.Views.Holes ||= {}

class Secom.Views.Holes.ShowView extends Backbone.View
  template: JST["backbone/templates/holes/show"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    if (confirm('Чыгаша булагы өчсүнбү?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
