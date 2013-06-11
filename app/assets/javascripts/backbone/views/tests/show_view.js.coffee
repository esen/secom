Secom.Views.Tests ||= {}

class Secom.Views.Tests.ShowView extends Backbone.View
  template: JST["backbone/templates/tests/show"]

  events:
    "click .destroy": "destroy"

  destroy: () ->
    if (confirm('Группа өчүрүлсүнбү?'))
      @model.destroy()
      this.remove()
      router.index()

  save: () =>
    @marks = []
    tests = new Secom.Collections.TestsCollection()

    @students.each (student) =>
      @marks.push student.get('id') + '=' + $("#student#{student.get('id')}").val()

    data = "test_id=#{@model.get('id')}&marks=#{@marks.join('|')}"
    $.post(tests.url + '/marks', data, @handle_save_response, 'json')

  handle_save_response: (resp, status, xhr) =>
    if resp["status"] == "success"
      @results = resp["results"]
      @render_students()
      alert("Сакталды!")
    else
      alert("Ката чыкты!")

  indexResults: =>
    @results_collection = new Secom.Collections.TestResultsCollection()
    @students = new Secom.Collections.StudentsCollection()

    $.get(@results_collection.url, "test_id=#{@model.get('id')}", @handle_results_response, 'json')

  handle_results_response: (resp, status, xhr) =>
    @results = resp["results"]
    @students.reset(@students.parse(resp["students"]))
    @render_students()

  render_students: () =>
    @form = $("<form id=\"restuls\" name=\"results\" class='form-horizontal' style=\"margin: 0px;\">")
    button = $("<span class=\"btn btn-small btn-primary\" id=\"save_marks\">сакта</span>")
    button.on('click', () => @save())

    @students.each (student) =>
      id = student.get('id')
      value = @results[student.get('id')] || ''

      div = $("<div class=\"control-group\">")
      label = $("<label for=\"student#{id}\" class=\"control-label\">#{student.get('name') + ' ' + student.get('surname')}&nbsp;</label>")
      cdiv = $("<div class=\"controls\" style=\"margin: 0px;\"></div>")
      input = $("<input type=\"text\" class=\"text_field input-small\" id=\"student#{id}\" value=\"#{value}\">")

      cdiv.append(input)
      cdiv.append(label)
      div.html(cdiv)

      @form.append(div)

    $("#sub_block").html(@form)
    $("#sub_block").append(button)

  render: ->
    $(@el).html(@template($.extend(@model.toJSON(), {homework: @options.homework})))
    @indexResults()

    return this
