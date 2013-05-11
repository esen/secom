Secom.Views.PaymentDates ||= {}

class Secom.Views.PaymentDates.NewView extends Backbone.View
  template: JST["backbone/templates/payment_dates/new"]

  tagName: 'tr'

  render: ->
    $(@el).html(@template(@model.toJSON()))
    $(@el).attr('id', 'new_payment_date_tr')

    return this
