Secom.Views.Tests ||= {}

class Secom.Views.Tests.NewView extends Backbone.View
  template: JST["backbone/templates/tests/new"]

  events:
    "submit #new-test": "save"

  constructor: (options) ->
    super(options)

    first_course_id = router.courses.first() && router.courses.first().get('id') || null
    @model = new @collection.model({homework: @options.homework, course_id: first_course_id})

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (test) =>
        @model = test
        course = router.courses.get(@model.get('course_id'))
        @model.set({course_name: course.get('lesson_name'), group_name: course.get('group_name')})
        window.location.hash = "/"

      error: (test, jqXHR) =>
        alert("Ката чыкты!")
    )

  addCourse: (course) =>
    view = new Secom.Views.Levels.OptionListView({model: course, selected_model_id: router.course.get('id'), name: 'lesson_group'})
    @$("#course_id").append(view.render().el)

  render: ->
    $(@el).html(@template($.extend(@model.toJSON(), {homework: @options.homework})))
    @$("#test_date").datepicker({"format": "dd-mm-yyyy", "defaultDate": @model.get('test_date')})
    router.courses.each(@addCourse)

    this.$("form").backboneLink(@model)

    return this
