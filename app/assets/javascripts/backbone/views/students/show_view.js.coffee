Secom.Views.Students ||= {}

class Secom.Views.Students.ShowView extends Backbone.View
  template: JST["backbone/templates/students/show"]
  ac_template: JST["backbone/templates/students/show_ac"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    if ur == 'ad' && (confirm('Are you sure?'))
      @model.destroy()
      this.remove()
      router.index()

  update_amounts: () ->
    if @payed != null && @to_pay != null
      @payed = 0

      @payments.forEach (payment) =>
        @payed += parseInt(payment.get('amount'))

      debt = Math.max(@to_pay - @payed, 0)
      loan = Math.max(@payed - @to_pay, 0)

      @$("#loan").attr("style", "color: green;") if loan > 0
      @$("#debt").attr("style", "color: red;") if debt > 0

      @$("#payed").html(@payed)
      @$("#debt").html(debt)
      @$("#loan").html(loan)

  render: ->
    @group = @options.group || @options.groups.get(@model.get('group_id'))

    switch ur
      when 'ac'
        @payment_dates = new Secom.Collections.PaymentDatesCollection()
        @payments = new Secom.Collections.PaymentsCollection()

        @to_pay = null
        @payed = null

        $.get(@payment_dates.url, "group_id=#{@group.get('id')}", @handle_payment_dates_response, 'json')
        $.get(@payments.url, "student_id=#{@model.get('id')}", @handle_payments_response, 'json')

        attribs = $.extend(@model.toJSON(),{group: @group})
        $(@el).html(@ac_template(attribs))

        router.student_view = this
        @view = new Secom.Views.Payments.IndexView(payments: @payments, sources: null)
        $("#payments").html(@view.render().el)
      else
        group_name = unless @group
          '-'
        else
          @group.get('name')

        attribs = $.extend(@model.toJSON(),{group_name: group_name, group: @options.group || null})
        $(@el).html(@template(attribs))

    return this

  handle_payment_dates_response: (resp, status, xhr) =>
    @payment_dates.reset(@payment_dates.parse(resp))

    @to_pay = to_pay_group = 0
    @payment_dates.forEach (pd) =>
      if pd.get('payment_date') <= today
        to_pay_group += pd.get('amount')


    student_started_at = @model.get('started_at')
    if student_started_at
      @payment_dates.forEach (pd) =>
        if student_started_at <= pd.get('payment_date') <= today
          @to_pay += pd.get('amount')
    else
      @to_pay = to_pay_group

    @$("#to_pay_group").html(to_pay_group)
    @$("#to_pay").html(@to_pay)

    # subtract discount
    discount = parseInt(@model.get('discount'))
    discount = 0 unless discount

    @to_pay -= discount
    @update_amounts()

  handle_payments_response: (resp, status, xhr) =>
    @payments.reset(@payments.parse(resp))
    @payed = 0
    @update_amounts()
