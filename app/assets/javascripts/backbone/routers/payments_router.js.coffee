class Secom.Routers.PaymentsRouter extends Backbone.Router
  initialize: (options) ->
    @payments = new Secom.Collections.PaymentsCollection()
    @payments.reset options.payments
    @sources = new Secom.Collections.SourcesCollection()
    @sources.reset options.sources

  routes:
    "new"      : "newPayment"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newPayment: ->
    @view = new Secom.Views.Payments.NewView(collection: @payments, sources: @sources)
    $("#payments").html(@view.render().el)

  index: ->
    @view = new Secom.Views.Payments.IndexView(payments: @payments, sources: @sources)
    $("#payments").html(@view.render().el)

  show: (id) ->
    payment = @payments.get(id)

    @view = new Secom.Views.Payments.ShowView(model: payment, sources: @sources)
    $("#payments").html(@view.render().el)

  edit: (id) ->
    payment = @payments.get(id)

    @view = new Secom.Views.Payments.EditView(model: payment, sources: @sources)
    $("#payments").html(@view.render().el)
