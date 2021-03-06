Secom.Views.Payments ||= {}

class Secom.Views.Payments.IndexView extends Backbone.View
  template: JST["backbone/templates/payments/index"]

  events:
    "submit #new-payment": "save"

  initialize: () ->
    @payments = @options.payments
    @payments.bind('reset', @addAll)

    if router.student_view
      @student_view = router.student_view
      @student = @student_view.model

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @payments.create(@model.toJSON(),
      success: (payment) =>
        @model = payment
        @new_view.remove()
        @addOne(payment)
        @student_view.update_amounts()
        @addNew()

      error: (payment, jqXHR) =>
        alert("Төлөм кошууда ката чыкты!")
    )

  addAll: () =>
    @total_amount = 0
    @payments.each(@addOne)

    # add total amount row
    unless router.student_view
      tr = $(document.createElement("tr"))
      td = $(document.createElement("td"))
      td.attr('colspan', '4')
      td.html("Бардыгы: <b>#{@total_amount}</b>")
      tr.html(td)
      @$("tbody").append(tr)

  addOne: (payment) =>
    @total_amount += payment.get('amount')
    view = new Secom.Views.Payments.PaymentView({model : payment, sources: @options.sources})
    @$("tbody").append(view.render().el)

  addNew: () =>
    @model = new @payments.model({student_id: @student.get('id'), payed_at: today})

    @model.bind("change:errors", () =>
      this.render()
    )

    @new_view = new Secom.Views.Payments.NewACView(model: @model)
    @$("#new_payment").html(@new_view.render().el)

  render: =>
    $(@el).html(@template($.extend(payments: @payments.toJSON(), {sources: @options.sources})))
    @addAll()
    @addNew() unless @options.sources

    return this
