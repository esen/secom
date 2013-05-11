Secom.Views.GenerateDatesView ||= {}

class Secom.Views.PaymentDates.GenerateDatesView extends Backbone.View
  template: JST["backbone/templates/payment_dates/generate_dates"]

  events: "click #generate": "generate"

  initialize: () ->
    @payment_dates = @options.payment_dates
    @group = @options.group
    @payment_dates.bind('reset', @addAll)

  generate: () ->
    if $("#each_month").is(":checked") || $("#days").is(":checked")
      if @payment_dates.length > 0
        confirmed = confirm("Мурда бул группага көрсөтүлгөн төлөө даталары өчүрүлөт!")
      else
        confirmed = true

      if confirmed
        @payment_dates = new Secom.Collections.PaymentDatesCollection()
        data = "started_at=#{$("#started_at").val()}"
        if $("#each_month").is(":checked")
          data += "&period=month&monthday=#{$("#monthday").val()}&monthsum=#{$("#monthsum").val()}"
        else
          data += "&period=days&daysday=#{$("#daysday").val()}&dayssum=#{$("#dayssum").val()}"

        $.get(@group.collection.url + "/#{@group.get('id')}", data, @handle_response, 'json')

  handle_response: (resp, status, xhr) =>
    if status == "success"
      console.log(resp)
      @payment_dates.reset(@payment_dates.parse(resp["payment_dates"]))
      @group.set('started_at', resp["group"]["started_at"])
      router.show(@group.get('id'))

  render: =>
    $(@el).html(@template(group: @group))

    return this
