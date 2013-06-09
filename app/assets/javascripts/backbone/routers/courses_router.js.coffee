class Secom.Routers.CoursesRouter extends Backbone.Router
  initialize: (options) ->
    @courses = new Secom.Collections.CoursesCollection()
    @courses.reset options.courses

  routes:
    "index"    : "index"
    ":id"      : "show"
    ":id/students/:student_id": "showStudent"
    ".*"        : "index"

    ":id/attendances/index":   "indexAttendances"

  index: ->
    $("#sub_block").empty()
    @view = new Secom.Views.Courses.IndexWithDetailsView(courses: @courses)
    $("#courses").html(@view.render().el)

  show: (id) ->
    course = @courses.get(id)

    @students = new Secom.Collections.StudentsCollection()
    $.get(@students.url, "group_id=#{course.get('group_id')}", @handle_students_response, 'json')

    @view = new Secom.Views.Courses.ShowView(model: course)
    $("#courses").html(@view.render().el)
    @show_rendered = true

  handle_students_response: (resp, status, xhr) =>
    @students.reset(@students.parse(resp["students"]))
    @group = new Secom.Models.Group(resp["group"])

    view = new Secom.Views.Students.IndexView(students: @students, group: @group, with_payments: false)
    $("#sub_block").html(view.render().el)

  showStudent: (id, student_id) ->
    unless @show_rendered
      @index()
    else
      student = @students.get(student_id)

      @view = new Secom.Views.Students.ShowView(model: student, group: @group)
      $("#sub_block").html(@view.render().el)

  indexAttendances: (id) ->
    unless @show_rendered
      @index()
    else
      @course = @courses.get(id)

      @attendances = new Secom.Collections.AttendancesCollection()
      $.get(@attendances.url, "course_id=#{id}", @handle_attendances_response, 'json')

  handle_attendances_response: (resp, status, xhr) =>
    @attendances.reset(@attendances.parse(resp["attendances"]))
    @dates = resp["course_dates"]

    view = new Secom.Views.Attendances.IndexView(attendances: @attendances, dates: @dates)
    $("#sub_block").html(view.render().el)
