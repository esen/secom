Secom.Views.Expenses ||= {}

class Secom.Views.Expenses.NewView extends Backbone.View
  template: JST["backbone/templates/expenses/new"]

  events:
    "submit #new-expense": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model({expended_at: today})
    if @options.teacher
      @model.set('teacher_id', @options.teacher.get('id'))

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (expense) =>
        @model = expense
        path = if @options.teacher
          "/#{@options.teacher.get('id')}/expenses/#{@model.get('id')}"
        else
          "/#{@model.get('id')}"
        window.location.hash = path

      error: (expense, jqXHR) =>
        alert("Чыгаша кошууда ката чыкты!")
    )

  addHole: (hole) =>
    view = new Secom.Views.Levels.OptionListView({model: hole, selected_model_id: @model.get('hole_id')})
    @$("#hole_id").append(view.render().el)

  addTeacher: (teacher) =>
    view = new Secom.Views.Levels.OptionListView({model: teacher, selected_model_id: @model.get('teacher_id')})
    @$("#teacher_id").append(view.render().el)

  render: ->
    $(@el).html(@template($.extend(@model.toJSON(), {teacher: @options.teacher || null})))
    router.holes.each(@addHole) if router.holes
    router.teachers.each(@addTeacher) if router.teachers

    this.$("form").backboneLink(@model)

    return this
