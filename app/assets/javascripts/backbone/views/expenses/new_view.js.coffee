Secom.Views.Expenses ||= {}

class Secom.Views.Expenses.NewView extends Backbone.View
  template: JST["backbone/templates/expenses/new"]

  events:
    "submit #new-expense": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model({expended_at: today})

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
        window.location.hash = "/#{@model.id}"

      error: (expense, jqXHR) =>
        alert("Чыгаша кошууда ката чыкты!")
    )

  addHole: (hole) =>
    view = new Secom.Views.Levels.OptionListView({model: hole, selected_model_id: @model.get('hole_id')})
    @$("#hole_id").append(view.render().el)

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    @options.holes.each(@addHole)

    this.$("form").backboneLink(@model)

    return this
