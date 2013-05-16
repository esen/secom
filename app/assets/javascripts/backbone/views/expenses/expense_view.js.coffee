Secom.Views.Expenses ||= {}

class Secom.Views.Expenses.ExpenseView extends Backbone.View
  template: JST["backbone/templates/expenses/expense"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Чыгаша өчүрүлсүнбү?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    hole = @options.holes.get(@model.get('hole_id'))
    hole = unless hole
      '-'
    else
      hole.get('name')

    attribs = $.extend(@model.toJSON(),{hole: hole})
    $(@el).html(@template(attribs))

    return this