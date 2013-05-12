Secom.Views.Payments ||= {}

class Secom.Views.Payments.NewACView extends Backbone.View
  template: JST["backbone/templates/payments/new_ac"]

  render: ->
    $(@el).html(@template(@options.model.toJSON() ))

    this.$("form").backboneLink(@options.model)

    return this
