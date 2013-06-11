Secom.Views.Tests ||= {}

class Secom.Views.Tests.EditView extends Backbone.View
  template : JST["backbone/templates/tests/edit"]

  events :
    "submit #edit-test" : "update"


  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (test) =>
        @model = test
        course = router.courses.get(@model.get('course_id'))
        @model.set({course_name: course.get('lesson_name'), group_name: course.get('group_name')})
        window.location.hash = "/#{@model.id}"

      error: (test, jqXHR) =>
        alert("Ката чыкты!")
    )

  addCourse: (course) =>
    view = new Secom.Views.Levels.OptionListView({model: course, selected_model_id: @model.get('course_id'), name: 'lesson_group'})
    @$("#course_id").append(view.render().el)

  render : ->
    $(@el).html(@template($.extend(@model.toJSON(), {homework: @options.homework})))
    @$("#test_date").datepicker({"format": "dd-mm-yyyy"})
    router.courses.each(@addCourse)

    this.$("form").backboneLink(@model)

    return this
