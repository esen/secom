class Secom.Routers.GroupsRouter extends Backbone.Router
  initialize: (options) ->
    @groups = new Secom.Collections.GroupsCollection()
    @groups.reset options.groups
    @levels = new Secom.Collections.LevelsCollection()
    @levels.reset options.levels
    @lessons = new Secom.Collections.LessonsCollection()
    @lessons.reset options.lessons
    @course_times = new Secom.Collections.CourseTimesCollection()
    @course_times.reset options.course_times
    @teachers = new Secom.Collections.TeachersCollection()
    @teachers.reset options.teachers
    @rooms = new Secom.Collections.RoomsCollection()
    @rooms.reset options.rooms

  routes:
    ":id/students/new": "newStudent"
    ":id/students/*": "indexStudents"
    ":id/students/index": "indexStudents"
    ":id/students/:student_id/edit": "editStudent"
    ":id/students/:student_id/discount": "discounttoStudent"
    ":id/students/:student_id": "showStudent"

    "index/grouped": "indexGrouped"
    "new": "newGroup"
    "index": "index"
    ":id/edit": "edit"
    ":id": "show"
    ":id/payment_dates": "indexPaymentDates"
    ":id/courses": "indexCourses"
    ".*": "index"

  newGroup: ->
    @view = new Secom.Views.Groups.NewView(collection: @groups, levels: @levels)
    $("#groups").html(@view.render().el)

  index: ->
    if ur != "vd"
      @indexGrouped()
    else
      @pd_view.remove() if @pd_view
      @c_view.remove() if @c_view
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
    @show_rendered = true

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
    @payment_dates = new Secom.Collections.PaymentDatesCollection()
    @payment_dates.reset(@payment_dates.parse(resp["payment_dates"]))

    with_payments = (ur == 'ac' ? false : true)
    view = new Secom.Views.Students.IndexView(students: @students, group: @group, payment_dates: @payment_dates, with_payments: with_payments)
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

  discounttoStudent: (id, student_id) ->
    unless @index_group_rendered
      @indexGrouped()
    else
      student = @students.get(student_id)
      group = @groups.get(id)

      @view = new Secom.Views.Students.DiscountView(model: student, groups: @groups, group: group)
      $("#students").html(@view.render().el)


  # Payment Dates of the group
  indexPaymentDates: (id) ->
    @show(id) unless @show_rendered
    @c_view.remove() if @c_view
    @payment_dates = new Secom.Collections.PaymentDatesCollection()
    @group = @groups.get(id)

    $.get(@payment_dates.url, "group_id=#{id}", @handle_payment_dates_response, 'json')

  handle_payment_dates_response: (resp, status, xhr) =>
    @payment_dates.reset(@payment_dates.parse(resp))

    @pd_view = new Secom.Views.PaymentDates.IndexView(payment_dates: @payment_dates, group: @group)
    $("#payment_dates").html(@pd_view.render().el)

  showPaymentDatesGenerate: (id) ->
    @group = @groups.get(id)
    @pd_view = new Secom.Views.PaymentDates.GenerateDatesView(group: @group)
    $("#payment_dates").html(@pd_view.render().el)

  # Courses of the group
  indexCourses: (id, collection) ->
    @show(id) unless @show_rendered
    @pd_view.remove() if @pd_view

    @courses = collection || new Secom.Collections.CoursesCollection()
    @group = @groups.get(id)

    if collection
      @c_view = new Secom.Views.Courses.IndexView(courses: @courses, group: @group)
      $("#courses").html(@c_view.render().el)
    else
      $.get(@courses.url, "group_id=#{id}", @handle_courses_response, 'json')

  handle_courses_response: (resp, status, xhr) =>
    @courses.reset(@courses.parse(resp))


    @c_view = new Secom.Views.Courses.IndexView(courses: @courses, group: @group)
    $("#courses").html(@c_view.render().el)
