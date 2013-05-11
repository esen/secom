Secom.Views.Payments ||= {}

class Secom.Views.Payments.IndexView extends Backbone.View
  template: JST["backbone/templates/payments/index"]

  initialize: () ->
    @options.payments.bind('reset', @addAll)

  addAll: () =>
    @options.payments.each(@addOne)

  addOne: (payment) =>
    view = new Secom.Views.Payments.PaymentView({model : payment, sources: @options.sources})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(payments: @options.payments.toJSON() ))
    @addAll()

    return this
