class Secom.Routers.CoursesRouter extends Backbone.Router
  initialize: (options) ->
    @courses = new Secom.Collections.CoursesCollection()
    @courses.reset options.courses

  routes:
    "new"      : "newCourse"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newCourse: ->
    @view = new Secom.Views.Courses.NewView(collection: @courses)
    $("#courses").html(@view.render().el)

  index: ->
    @view = new Secom.Views.Courses.IndexView(courses: @courses)
    $("#courses").html(@view.render().el)

  show: (id) ->
    course = @courses.get(id)

    @view = new Secom.Views.Courses.ShowView(model: course)
    $("#courses").html(@view.render().el)

  edit: (id) ->
    course = @courses.get(id)

    @view = new Secom.Views.Courses.EditView(model: course)
    $("#courses").html(@view.render().el)
