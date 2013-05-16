Secom.Views.Expenses ||= {}

class Secom.Views.Expenses.EditView extends Backbone.View
  template : JST["backbone/templates/expenses/edit"]

  events :
    "submit #edit-expense" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (expense) =>
        @model = expense
        window.location.hash = "/#{@model.id}"
    )

  addHole: (hole) =>
    view = new Secom.Views.Levels.OptionListView({model: hole, selected_model_id: @model.get('hole_id')})
    @$("#hole_id").append(view.render().el)

  render : ->
    $(@el).html(@template(@model.toJSON() ))
    @options.holes.each(@addHole)


    this.$("form").backboneLink(@model)

    return this
