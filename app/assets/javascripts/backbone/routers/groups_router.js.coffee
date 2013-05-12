class Secom.Routers.GroupsRouter extends Backbone.Router
  initialize: (options) ->
    @groups = new Secom.Collections.GroupsCollection()
    @groups.reset options.groups
    @levels = new Secom.Collections.LevelsCollection()
    @levels.reset options.levels

  routes:
    ":id/students/new": "newStudent"
    ":id/students/*": "indexStudents"
    ":id/students/index": "indexStudents"
    ":id/students/:student_id/edit": "editStudent"
    ":id/students/:student_id": "showStudent"

    "index/grouped": "indexGrouped"
    "new": "newGroup"
    "index": "index"
    ":id/edit": "edit"
    ":id": "show"
    ".*": "index"

  newGroup: ->
    @view = new Secom.Views.Groups.NewView(collection: @groups, levels: @levels)
    $("#groups").html(@view.render().el)

  index: ->
    if ur != "vd"
      @indexGrouped()
    else
      @pd_view.remove() if @pd_view
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
    @indexPaymentDates(id)

  edit: (id) ->
    group = @groups.get(id)

    @view = new Secom.Views.Groups.EditView(model: group, levels: @levels)
    $("#groups").html(@view.render().el)

  # Students of the group
  indexStudents: (id) ->
    @indexGrouped() unless @index_group_rendered

    @students = new Secom.Collections.StudentsCollection()
    @group = @groups.get(id)
    $("#payments").children().remove()

    $.get(@students.url, "group_id=#{id}", @handle_students_response, 'json')

  handle_students_response: (resp, status, xhr) =>
    @students.reset(@students.parse(resp["students"]))
    @group.set(resp["group"])

    view = new Secom.Views.Students.IndexView(students: @students, group: @group, with_payments: true)
    $("#students").html(view.render().el)

  newStudent: (id) ->
    unless @index_group_rendered
      @indexGrouped()
    else
      group = @groups.get(id)

      @view = new Secom.Views.Students.NewView(collection: @students, group: group)
      $("#students").html(@view.render().el)

  showStudent: (id, student_id) ->
    unless @index_group_rendered
      @indexGrouped()

      if ur == 'ac'
        @students = new Secom.Collections.StudentsCollection()
        @group = @groups.get(id)
        $.get(@students.url + "/#{student_id}", "", @handle_student_response, 'json')
    else
      student = @students.get(student_id)
      group = @groups.get(id)

      @view = new Secom.Views.Students.ShowView(model: student, groups: @groups, group: group)
      $("#students").html(@view.render().el)

  handle_student_response: (resp, status, xhr) =>
    student = new @students.model(resp)
    @view = new Secom.Views.Students.ShowView(model: student, groups: @groups, group: @group)
    $("#students").html(@view.render().el)

  editStudent: (id, student_id) ->
    unless @index_group_rendered
      @indexGrouped()
    else
      student = @students.get(student_id)
      group = @groups.get(id)

      @view = new Secom.Views.Students.EditView(model: student, groups: @groups, group: group)
      $("#students").html(@view.render().el)

  # Payment Dates of the group
  indexPaymentDates: (id) ->
    @payment_dates = new Secom.Collections.PaymentDatesCollection()
    @group = @groups.get(id)

    $.get(@payment_dates.url, "group_id=#{id}", @handle_payment_dates_response, 'json')

  handle_payment_dates_response: (resp, status, xhr) =>
    @payment_dates.reset(@payment_dates.parse(resp))

    @pd_view = new Secom.Views.PaymentDates.IndexView(payment_dates: @payment_dates, group: @group)
    $("#payment_dates").html(@pd_view.render().el)

  showPaymentDatesGenerate: (id) ->
    @group = @groups.get(id)
    @pd_view = new Secom.Views.PaymentDates.GenerateDatesView(payment_dates: @payment_dates, group: @group)
    $("#payment_dates").html(@pd_view.render().el)

