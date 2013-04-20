Secom.Views.CourseTimes ||= {}

class Secom.Views.CourseTimes.EditView extends Backbone.View
  template : JST["backbone/templates/course_times/edit"]

  events :
    "submit #edit-course_time" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (course_time) =>
        @model = course_time
        window.location.hash = "/#{@model.id}"

      error: (course_time, jqXHR) =>
        @model.set("starts_at", @options.orig_values.starts_at)
        @model.set("ends_at", @options.orig_values.ends_at)
        alert($.parseJSON(jqXHR.responseText).join(", "))
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
