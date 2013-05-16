Secom.Views.Expenses ||= {}

class Secom.Views.Expenses.IndexView extends Backbone.View
  template: JST["backbone/templates/expenses/index"]

  initialize: () ->
    @options.expenses.bind('reset', @addAll)

  addAll: () =>
    @options.expenses.each(@addOne)

  addOne: (expense) =>
    view = new Secom.Views.Expenses.ExpenseView({model : expense, teacher : @options.teacher || null})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(expenses: @options.expenses.toJSON(), teacher: @options.teacher || null))
    @addAll()

    return this
