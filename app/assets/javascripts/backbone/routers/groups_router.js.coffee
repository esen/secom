global_students = null

class Secom.Routers.GroupsRouter extends Backbone.Router
  initialize: (options) ->
    @groups = new Secom.Collections.GroupsCollection()
    @groups.reset options.groups
    @levels = new Secom.Collections.LevelsCollection()
    @levels.reset options.levels

  routes:
    ":id/students/new"      : "newStudent"
    ":id/students/*"        : "indexStudents"
    ":id/students/index"    : "indexStudents"
    ":id/students/:student_id/edit" : "editStudent"
    ":id/students/:student_id"      : "showStudent"
    "index/grouped"     : "indexGrouped"
    "new"      : "newGroup"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newGroup: ->
    @view = new Secom.Views.Groups.NewView(collection: @groups, levels: @levels)
    $("#groups").html(@view.render().el)

  index: ->
    if ur != "vd"
      @indexGrouped()
    else
      @view = new Secom.Views.Groups.IndexView(groups: @groups, levels: @levels)
      $("#groups").html(@view.render().el)

  indexGrouped: ->
    @view = new Secom.Views.Groups.IndexGroupedView(groups: @groups, levels: @levels)
    $("#groups").html(@view.render().el)
    @index_group_rendered = true

  show: (id) ->
    group = @groups.get(id)

    @view = new Secom.Views.Groups.ShowView(model: group, levels: @levels)
    $("#groups").html(@view.render().el)

  edit: (id) ->
    group = @groups.get(id)

    @view = new Secom.Views.Groups.EditView(model: group, levels: @levels)
    $("#groups").html(@view.render().el)

  indexStudents: (id) ->
    @indexGrouped() unless @index_group_rendered

    global_students = new Secom.Collections.StudentsCollection()
    group = @groups.get(id)

    handle_response = (resp, status, xhr) ->
      global_students.reset(global_students.parse(resp))
      view = new Secom.Views.Students.IndexView(students: global_students, group: group)
      $("#students").html(view.render().el)

    $.get(global_students.url, "group_id=#{id}", handle_response, 'json')

  newStudent: (id) ->
    unless @index_group_rendered
      @indexGrouped()
    else
      group = @groups.get(id)

      @view = new Secom.Views.Students.NewView(collection: global_students, group: group)
      $("#students").html(@view.render().el)

  showStudent: (id, student_id) ->
    unless @index_group_rendered
      @indexGrouped()
    else
      student = global_students.get(student_id)
      group = @groups.get(id)

      @view = new Secom.Views.Students.ShowView(model: student, groups: @groups, group: group)
      $("#students").html(@view.render().el)

  editStudent: (id, student_id) ->
    unless @index_group_rendered
      @indexGrouped()
    else
      student = global_students.get(student_id)
      group = @groups.get(id)

      @view = new Secom.Views.Students.EditView(model: student, groups: @groups, group: group)
      $("#students").html(@view.render().el)
