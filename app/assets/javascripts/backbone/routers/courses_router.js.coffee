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

  indexAttendances: (id, show_all = false) ->
    unless @show_rendered
      @index()
    else
      @course = @courses.get(id)

      @attendances = new Secom.Collections.AttendancesCollection()
      data = "course_id=#{id}"
      data += "&all=true" if show_all
      $.get(@attendances.url, data, @handle_attendances_response, 'json')

  handle_attendances_response: (resp, status, xhr) =>
    @students = new Secom.Collections.StudentsCollection()

    @attendances.reset(@attendances.parse(resp["attendances"]))
    @attendances.reset(@attendances.sortBy((a) -> a.get('checked_at')))
    @students.reset(@students.parse(resp["students"]))

    @a_view = new Secom.Views.Attendances.IndexView(attendances: @attendances, students: @students)
    $("#sub_block").html(@a_view.render().el)

    disabled_days = []
    disabled_days.push 0 unless @course.get('monday')
    disabled_days.push 1 unless @course.get('tuesday')
    disabled_days.push 2 unless @course.get('wednesday')
    disabled_days.push 3 unless @course.get('thursday')
    disabled_days.push 4 unless @course.get('friday')
    disabled_days.push 5 unless @course.get('saturday')
    disabled_days.push 6 unless @course.get('sunday')

    @checkout = $('#date_to_check').datepicker({
      format: "yyyy-mm-dd",
      daysOfWeekDisabled: disabled_days
    }).on('changeDate', (ev) =>
      @checkout.hide()
    ).data('datepicker')
