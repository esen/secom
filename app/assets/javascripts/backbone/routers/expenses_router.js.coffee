class Secom.Routers.ExpensesRouter extends Backbone.Router
  initialize: (options) ->
    @expenses = new Secom.Collections.ExpensesCollection()
    @expenses.reset options.expenses
    @holes = new Secom.Collections.HolesCollection()
    @holes.reset options.holes
    @teachers = new Secom.Collections.TeachersCollection()
    @teachers.reset options.teachers

  routes:
    "new"      : "newExpense"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newExpense: ->
    @view = new Secom.Views.Expenses.NewView(collection: @expenses)
    $("#expenses").html(@view.render().el)

  index: ->
    @view = new Secom.Views.Expenses.IndexView(expenses: @expenses)
    $("#expenses").html(@view.render().el)

  show: (id) ->
    expense = @expenses.get(id)

    @view = new Secom.Views.Expenses.ShowView(model: expense)
    $("#expenses").html(@view.render().el)

  edit: (id) ->
    expense = @expenses.get(id)

    @view = new Secom.Views.Expenses.EditView(model: expense)
    $("#expenses").html(@view.render().el)
