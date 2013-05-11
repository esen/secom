Secom.Views.PaymentDates ||= {}

class Secom.Views.PaymentDates.ShowView extends Backbone.View
  template: JST["backbone/templates/payment_dates/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
