Secom.Views.Payments ||= {}

class Secom.Views.Payments.EditACView extends Backbone.View
  template : JST["backbone/templates/payments/edit_ac"]

  tagName: 'td'

  render : ->
    $(@el).html(@template(@model.toJSON() ))
    $(@el).attr('colspan', 4)
    this.$("form").backboneLink(@model)

    return this
