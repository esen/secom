Secom.Views.Payments ||= {}

class Secom.Views.Payments.EditView extends Backbone.View
  template : JST["backbone/templates/payments/edit"]

  events :
    "submit #edit-payment" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (payment) =>
        @model = payment
        window.location.hash = "/#{@model.id}"
    )

  addSource: (source) =>
    view = new Secom.Views.Levels.OptionListView({model: source, selected_model_id: @model.get('source_id')})
    @$("#source_id").append(view.render().el)

  render : ->
    $(@el).html(@template(@model.toJSON() ))
    @options.sources.each(@addSource)


    this.$("form").backboneLink(@model)

    return this
