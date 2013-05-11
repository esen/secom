Secom.Views.PaymentDates ||= {}

class Secom.Views.PaymentDates.EditView extends Backbone.View
  template : JST["backbone/templates/payment_dates/edit"]

  events :
    "submit #edit-payment_date" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (payment_date) =>
        @model = payment_date
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
