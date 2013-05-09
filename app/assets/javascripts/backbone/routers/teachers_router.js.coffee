class Secom.Routers.TeachersRouter extends Backbone.Router
  initialize: (options) ->
    @teachers = new Secom.Collections.TeachersCollection()
    @teachers.reset options.teachers
    @lessons = new Secom.Collections.LessonsCollection()
    @lessons.reset options.lessons

  routes:
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

  show: (id) ->
    teacher = @teachers.get(id)

    @view = new Secom.Views.Teachers.ShowView(model: teacher, lessons: @lessons)
    $("#teachers").html(@view.render().el)

  edit: (id) ->
    teacher = @teachers.get(id)

    @view = new Secom.Views.Teachers.EditView(model: teacher, lessons: @lessons)
    $("#teachers").html(@view.render().el)
