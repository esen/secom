Secom.Views.Attendances ||= {}

class Secom.Views.Attendances.NewView extends Backbone.View
  template: JST["backbone/templates/attendances/new"]

  events:
    "click #save": "save"

  constructor: (options) ->
    super(options)
    @selected_date = options.selected_date
    @students = options.students
    @attendances = options.attendances

  save: (e) ->
    @checked_students = []

    @students.each (student) =>
      @checked_students.push student.get('id') if $("#student#{student.get('id')}").is(":checked")

    data = "course_id=#{router.course.get('id')}&date=#{@selected_date}&students=#{@checked_students.join('|')}"
    $.post(router.attendances.url + '/check', data, @handle_check_response, 'json')

  handle_check_response: (resp, status, xhr) =>
    if resp["status"] == "success"
      router.a_view.remove()
      router.indexAttendances(router.course.get('id'))
    else
      alert("Ката чыкты!")

  render: ->
    $(@el).html(@template({selected_date: @selected_date}))
    $(@el).addClass("row")

    @students.each (student) =>
      div = $("<div class=\"control-group\">")
      label = $("<label for=\"student#{student.get('id')}\" class=\"control-label\">#{student.get('name') + ' ' + student.get('surname')}&nbsp;</label>")
      cdiv = $("<div class=\"controls\" style=\"margin: 0px;\"></div>")

      checked = if @attendances[student.get('id')] then 'checked' else ''
      input = $("<input type=\"checkbox\" class=\"check_box\" id=\"student#{student.get('id')}\" #{checked}>")

      cdiv.append(input)
      cdiv.append(label)
      div.html(cdiv)

      @$("#new-attendance").append(div)

    return this
