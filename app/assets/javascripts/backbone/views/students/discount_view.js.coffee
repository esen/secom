Secom.Views.Students ||= {}

class Secom.Views.Students.DiscountView extends Backbone.View
  template : JST["backbone/templates/students/discount"]

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
    this.$("form").backboneLink(@model)

    return this
