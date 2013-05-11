Secom.Views.PaymentDates ||= {}

class Secom.Views.PaymentDates.IndexView extends Backbone.View
  template: JST["backbone/templates/payment_dates/index"]

  events:
    "submit #new-payment_date": "save"
    "click #check_total_amount": "check_total_amount"

  initialize: () ->
    @payment_dates = @options.payment_dates
    @group = @options.group
    @payment_dates.bind('reset', @addAll)

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @payment_dates.create(@model.toJSON(),
      success: (payment_date) =>
        @$("#new_payment_date_tr").remove()
        $("#total_amount").html(@payment_dates.total_amount())
        @addOne(payment_date)
        @addNewForm()

      error: (payment_date, jqXHR) =>
        errors = $.parseJSON(jqXHR.responseText)
        alert(errors)
        payment_date.collection.remove(payment_date)
    )

  check_total_amount: (e) ->
    if @group.is_valid(@payment_dates)
      alert("Төлөө даталары туура.")
    else
      difference = @group.get('price') - @payment_dates.total_amount()

      if difference == 0
        alert("Курстун башталышынан мурда акча төлөнбөйт!")
      else if difference > 0
        alert("#{difference} сомго жаңы төлөө датасын кошуңуз!")
      else
        alert("#{Math.abs(difference)} сом ашыкча!")

  addAll: () =>
    @payment_dates.each(@addOne)

  addOne: (payment_date) =>
    view = new Secom.Views.PaymentDates.PaymentDateView({model: payment_date, group: @group})
    @$("tbody").append(view.render().el)

  addNewForm: () =>
    @model = new @payment_dates.model({group_id: @group.get('id')})

    @model.bind("change:errors", () =>
      this.render()
    )
    view = new Secom.Views.PaymentDates.NewView({model: @model})
    @$("tbody").append(view.render().el)

    this.$("form").backboneLink(@model)


  render: =>
    $(@el).html(@template(group: @group))
    @addAll()
    @addNewForm() unless @group.get('active')
    @$("#total_amount").html(@payment_dates.total_amount())

    return this
