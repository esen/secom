Secom.Views.PaymentDates ||= {}

class Secom.Views.PaymentDates.PaymentDateView extends Backbone.View
  template: JST["backbone/templates/payment_dates/payment_date"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    collection = @model.collection
    @model.destroy()
    $("#total_amount").html(collection.total_amount())
    this.remove()

    return false

  render: ->
    attribs = $.extend(@model.toJSON(),{group: @options.group})

    $(@el).html(@template(attribs))
    $(@el).attr("id", "payment_date#{@model.get('id')}")

    return this
