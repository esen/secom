Secom.Views.Students ||= {}

class Secom.Views.Students.EditView extends Backbone.View
  template : JST["backbone/templates/students/edit"]

  events :
    "submit #edit-student" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (student) =>
        @model = student
        window.location.hash = "/#{@options.group.get('id')}/students/#{@model.id}"
      error: (student, jqXHR) =>
        alert($.parseJSON(jqXHR.responseText))
    )

  render : ->
    $(@el).html(@template(@model.toJSON()))
    student_group_id = @model.get("group_id")
    group_select = @$("#group_id")

    @options.groups.forEach (group) ->
      option = $(document.createElement("option"))
      option.html(group.get("name"))
      option.val(group.get("id"))
      if student_group_id == group.get('id')
        option.attr('selected', 'true')

      group_select.append(option)

    this.$("form").backboneLink(@model)

    return this
