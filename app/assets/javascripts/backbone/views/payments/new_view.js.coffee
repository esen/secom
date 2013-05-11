Secom.Views.Payments ||= {}

class Secom.Views.Payments.NewView extends Backbone.View
  template: JST["backbone/templates/payments/new"]

  events:
    "submit #new-payment": "save"

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
      success: (payment) =>
        @model = payment
        window.location.hash = "/#{@model.id}"

      error: (payment, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  addSource: (source) =>
    view = new Secom.Views.Levels.OptionListView({model: source, selected_model_id: @model.get('source_id')})
    @$("#source_id").append(view.render().el)

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    @options.sources.each(@addSource)

    this.$("form").backboneLink(@model)

    return this
