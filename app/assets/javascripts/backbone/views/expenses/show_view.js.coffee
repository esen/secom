Secom.Views.Expenses ||= {}

class Secom.Views.Expenses.ShowView extends Backbone.View
  template: JST["backbone/templates/expenses/show"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    if (confirm('Чыгаша өчүрүлсүнбү?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    hole = @options.holes.get(@model.get('hole_id'))
    hole = unless hole
      '-'
    else
      hole.get('name')

    console.log(hole)

    $(@el).html(@template($.extend(@model.toJSON(), {hole: hole})))
    return this
