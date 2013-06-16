Secom.Views.Teachers ||= {}

class Secom.Views.Teachers.EditView extends Backbone.View
  template : JST["backbone/templates/teachers/edit"]

  events :
    "submit #edit-teacher" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    valid = true

    if $("#password").val().length > 0
      unless $("#password").val() == $("#password_confirmation").val()
        valid = false
        alert("Пароль менен парольдун кайталанышы окшош болуусу керек!")
        $("#password").val("")
        $("#password_confirmation").val("")

    if valid
      @model.save(null,
        success : (teacher) =>
          @model = teacher
          window.location.hash = "/#{@model.id}"

        error: (teacher, jqXHR) =>
          alert($.parseJSON(jqXHR.responseText))
      )

  addLesson: (lesson) =>
    view = new Secom.Views.Lessons.OptionListView({model: lesson, selected_model_id: @model.get('lesson_id')})
    @$("#lesson_id").append(view.render().el)

  render : ->
    $(@el).html(@template(@model.toJSON() ))
    @options.lessons.each(@addLesson)

    this.$("form").backboneLink(@model)

    return this
