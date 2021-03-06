Secom.Views.GenerateDatesView ||= {}

class Secom.Views.PaymentDates.GenerateDatesView extends Backbone.View
  template: JST["backbone/templates/payment_dates/generate_dates"]

  events: "click #generate": "generate"

  initialize: () ->
    @group = @options.group

  generate: () ->
    if $("#each_month").is(":checked") || $("#days").is(":checked")
      confirmed = confirm("Эгер мурда көрсөтүлгөн төлөө даталары туура эмес болсо өчүрүлөт!")

      if confirmed
        @payment_dates = new Secom.Collections.PaymentDatesCollection()
        data = "started_at=#{$("#started_at").val()}"
        if $("#each_month").is(":checked")
          data += "&period=month&monthday=#{$("#monthday").val()}&monthsum=#{$("#monthsum").val()}"
        else
          data += "&period=days&daysday=#{$("#daysday").val()}&dayssum=#{$("#dayssum").val()}"

        $.get(@group.collection.url + "/#{@group.get('id')}/activate", data, @handle_response, 'json')

  handle_response: (resp, status, xhr) =>
    if resp["status"] == "success"
      @payment_dates.reset(@payment_dates.parse(resp["payment_dates"]))
      @group.set(resp["group"])
      router.show(@group.get('id'))
      router.indexPaymentDates(@group.get('id'))
    else
      alert(resp["error"])

  render: =>
    $(@el).html(@template(group: @group))

    return this
