class Secom.Routers.PaymentDatesRouter extends Backbone.Router
  initialize: (options) ->
    @paymentDates = new Secom.Collections.PaymentDatesCollection()
    @paymentDates.reset options.paymentDates

  routes:
    "new"      : "newPaymentDate"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newPaymentDate: ->
    @view = new Secom.Views.PaymentDates.NewView(collection: @payment_dates)
    $("#payment_dates").html(@view.render().el)

  index: ->
    @view = new Secom.Views.PaymentDates.IndexView(payment_dates: @payment_dates)
    $("#payment_dates").html(@view.render().el)

  show: (id) ->
    payment_date = @payment_dates.get(id)

    @view = new Secom.Views.PaymentDates.ShowView(model: payment_date)
    $("#payment_dates").html(@view.render().el)

  edit: (id) ->
    payment_date = @payment_dates.get(id)

    @view = new Secom.Views.PaymentDates.EditView(model: payment_date)
    $("#payment_dates").html(@view.render().el)
