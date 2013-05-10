class Secom.Routers.StudentsRouter extends Backbone.Router
  initialize: (options) ->
    @students = new Secom.Collections.StudentsCollection()
    @students.reset options.students
    @groups = new Secom.Collections.GroupsCollection()
    @groups.reset options.groups

  routes:
    "index"    : "index"
    ":id"      : "show"
    ".*"        : "index"

  index: ->
    @view = new Secom.Views.Students.IndexView(students: @students, show_groups: true, groups: @groups)
    $("#students").html(@view.render().el)

  show: (id) ->
    student = @students.get(id)

    @view = new Secom.Views.Students.ShowView(model: student, groups: @groups)
    $("#students").html(@view.render().el)
