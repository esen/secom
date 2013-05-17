Secom.Views.Expenses ||= {}

class Secom.Views.Expenses.IndexView extends Backbone.View
  template: JST["backbone/templates/expenses/index"]

  initialize: () ->
    @options.expenses.bind('reset', @addAll)

  addAll: () =>
    @total_amount = 0
    @options.expenses.each(@addOne)

    # add total amount row
    tr = $(document.createElement("tr"))
    td = $(document.createElement("td"))
    td.attr('colspan', '7')
    td.html("Бардыгы: <b>#{@total_amount}</b>")
    tr.html(td)
    @$("tbody").append(tr)

  addOne: (expense) =>
    @total_amount += expense.get('amount')
    view = new Secom.Views.Expenses.ExpenseView({model : expense, teacher : @options.teacher || null})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(expenses: @options.expenses.toJSON(), teacher: @options.teacher || null))
    @addAll()

    return this
