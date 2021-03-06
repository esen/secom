Secom.Views.Teachers ||= {}

class Secom.Views.Teachers.NewView extends Backbone.View
  template: JST["backbone/templates/teachers/new"]

  events: "submit #new-teacher": "save"

  constructor: (options) ->
    super(options)
    first_lesson_id = @options.lessons.first() && @options.lessons.first().get('id') || null
    @model = new @collection.model({lesson_id: first_lesson_id})

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    if $("#password").val() == $("#password_confirmation").val()
      @collection.create(@model.toJSON(),
        success: (teacher) =>
          @model = teacher
          window.location.hash = "/#{@model.id}"

        error: (teacher, jqXHR) =>
          @model.remove()
          alert($.parseJSON(jqXHR.responseText))
      )
    else
      alert("Пароль менен парольдун кайталанышы окшош болуусу керек!")
      $("#password").val("")
      $("#password_confirmation").val("")

  addLesson: (lesson) =>
    view = new Secom.Views.Lessons.OptionListView({model: lesson})
    @$("#lesson_id").append(view.render().el)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @options.lessons.each(@addLesson)

    this.$("form").backboneLink(@model)

    return this
