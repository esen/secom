class Secom.Routers.LessonsRouter extends Backbone.Router
  initialize: (options) ->
    @lessons = new Secom.Collections.LessonsCollection()
    @lessons.reset options.lessons

  routes:
    "new"      : "newLesson"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newLesson: ->
    @view = new Secom.Views.Lessons.NewView(collection: @lessons)
    $("#lessons").html(@view.render().el)

  index: ->
    @view = new Secom.Views.Lessons.IndexView(lessons: @lessons)
    $("#lessons").html(@view.render().el)

  show: (id) ->
    lesson = @lessons.get(id)

    @view = new Secom.Views.Lessons.ShowView(model: lesson)
    $("#lessons").html(@view.render().el)

  edit: (id) ->
    lesson = @lessons.get(id)

    @view = new Secom.Views.Lessons.EditView(model: lesson)
    $("#lessons").html(@view.render().el)
