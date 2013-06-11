class Secom.Routers.TestsRouter extends Backbone.Router
  initialize: (options) ->
    @tests = new Secom.Collections.TestsCollection()
    @tests.reset options.tests
    @courses = new Secom.Collections.CoursesCollection()
    @courses.reset options.courses
    @course = new Secom.Models.Course(options.course)
    @homework = options.homework

  routes:
    "new"      : "newTest"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newTest: ->
    @view = new Secom.Views.Tests.NewView(collection: @tests, homework: @homework)
    $("#tests").html(@view.render().el)

  index: ->
    $("#sub_block").empty()
    @view = new Secom.Views.Tests.IndexView(tests: @tests, homework: @homework)
    $("#tests").html(@view.render().el)

  show: (id) ->
    test = @tests.get(id)

    @view = new Secom.Views.Tests.ShowView(model: test, homework: @homework)
    $("#tests").html(@view.render().el)

  edit: (id) ->
    test = @tests.get(id)

    @view = new Secom.Views.Tests.EditView(model: test, homework: @homework)
    $("#tests").html(@view.render().el)
