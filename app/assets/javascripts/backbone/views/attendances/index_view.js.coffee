Secom.Views.Attendances ||= {}

class Secom.Views.Attendances.IndexView extends Backbone.View
  template: JST["backbone/templates/attendances/index"]

  events:
    "change #date_to_check": "showForm"
    "click #show_all": "rerender"

  initialize: () ->
    @attendances = @options.attendances
    @students = @options.students
    @attendances.bind('reset', @addAll)

  addAll: () =>
    # generate needed objects
    @grouped_by_student = {}
    @grouped_by_date = {}
    @dates = {}
    @attendances.each (attendance) =>
      student_id = attendance.get('student_id')
      checked_at = attendance.get('checked_at')

      @grouped_by_student[student_id] = {} unless @grouped_by_student[student_id]
      @grouped_by_student[student_id][checked_at] = attendance.get('attended')

      @grouped_by_date[checked_at] = {} unless @grouped_by_date[checked_at]
      @grouped_by_date[checked_at][student_id] = attendance.get('attended')


      @dates[checked_at] = true unless @dates[checked_at]

    @dates = _(@dates).keys()

    # fill the table header
    @tr = $("<tr>")
    @tr.append($("<th>"))

    @dates.forEach (date) =>
      @tr.append($("<th>#{date}</th>"))

    @$("thead").append(@tr)

    # fill the table body
    @students.each (student) =>
      @tr = $("<tr>")
      td = $("<td>")
      td.html("<b>" + student.get('name') + ' ' + student.get('surname') + "</b>")
      @tr.append(td)

      @dates.forEach (date) =>
        attended = true if @grouped_by_student[student.get('id')] && @grouped_by_student[student.get('id')][date]
        value = if attended then 'P' else ''

        td = $("<td>#{value}</td>")
        @tr.append(td)

      @$("tbody").append(@tr)

  showForm: =>
    @selected_date = $("#date_to_check").val()
    attendances = @grouped_by_date[@selected_date]
    attendances = {} unless attendances

    view = new Secom.Views.Attendances.NewView(selected_date: @selected_date, students: @students, attendances: attendances)
    $("#new_row").html(view.render().el)


  render: =>
    $(@el).html(@template(attendances: @attendances.toJSON()))
    @addAll()

    return this

  rerender: =>
    this.remove()
    router.indexAttendances(router.course.get('id'), true)