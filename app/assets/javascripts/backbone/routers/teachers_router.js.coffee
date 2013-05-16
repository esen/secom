class Secom.Routers.TeachersRouter extends Backbone.Router
  initialize: (options) ->
    @teachers = new Secom.Collections.TeachersCollection()
    @teachers.reset options.teachers
    @lessons = new Secom.Collections.LessonsCollection()
    @lessons.reset options.lessons

  routes:
    ":id/expenses/new"              : "newExpense"
    ":id/expenses/index"            : "indexExpenses"
    ":id/expenses/:teacher_id/edit" : "editExpense"
    ":id/expenses/:teacher_id"      : "showExpense"

    "new"      : "newTeacher"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newTeacher: ->
    @view = new Secom.Views.Teachers.NewView(collection: @teachers, lessons: @lessons)
    $("#teachers").html(@view.render().el)

  index: ->
    @view = new Secom.Views.Teachers.IndexView(teachers: @teachers, lessons: @lessons)
    $("#teachers").html(@view.render().el)
    $("#expenses").html("")

  show: (id) ->
    @teacher = @teachers.get(id)

    @view = new Secom.Views.Teachers.ShowView(model: @teacher, lessons: @lessons)
    $("#teachers").html(@view.render().el)
    @teacher_rendered = true

  edit: (id) ->
    teacher = @teachers.get(id)

    @view = new Secom.Views.Teachers.EditView(model: teacher, lessons: @lessons)
    $("#teachers").html(@view.render().el)

  # expenses
  newExpense: (id) ->
    @show(id) unless @teacher_rendered

    @expenses = new Secom.Collections.ExpensesCollection() unless @expenses
    @view = new Secom.Views.Expenses.NewView(collection: @expenses, teacher: @teacher)
    $("#expenses").html(@view.render().el)

  indexExpenses: (id) ->
    @show(id) unless @teacher_rendered

    @expenses = new Secom.Collections.ExpensesCollection()
    $.get(@expenses.url, "teacher_id=#{@teacher.get('id')}", @handle_response, 'json')

  handle_response: (resp, status, xhr) =>
    @expenses.reset(@expenses.parse(resp))

    @view = new Secom.Views.Expenses.IndexView(expenses: @expenses, teacher: @teacher)
    $("#expenses").html(@view.render().el)

  showExpense: (id, teacher_id) ->
    unless @teacher_rendered
      @show(id)
    else
      expense = @expenses.get(teacher_id)

      @view = new Secom.Views.Expenses.ShowView(model: expense, teacher: @teacher)
      $("#expenses").html(@view.render().el)

  editExpense: (id, teacher_id) ->
    unless @teacher_rendered
      @show(id)
    else
      expense = @expenses.get(teacher_id)

      @view = new Secom.Views.Expenses.EditView(model: expense, teacher: @teacher)
      $("#expenses").html(@view.render().el)

