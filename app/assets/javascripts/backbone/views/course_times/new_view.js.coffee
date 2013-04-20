Secom.Views.CourseTimes ||= {}

class Secom.Views.CourseTimes.NewView extends Backbone.View
  template: JST["backbone/templates/course_times/new"]

  events:
    "submit #new-course_time": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (course_time) =>
        @model = course_time
        window.location.hash = "/#{@model.id}"

      error: (course_time, jqXHR) =>
        course_time.collection.remove(course_time)
        alert($.parseJSON(jqXHR.responseText).join(", "))
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
