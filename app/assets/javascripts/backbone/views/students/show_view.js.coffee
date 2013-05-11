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

  render: ->
    @group = @options.groups.get(@model.get('group_id'))

    switch ur
      when 'ac'
        @payment_dates = new Secom.Collections.PaymentDatesCollection()

        $.get(@payment_dates.url, "group_id=#{@group.get('id')}", @handle_payment_dates_response, 'json')
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
    to_pay = 0
    @payment_dates.forEach (pd) =>
      if pd.get('payment_date') <= today
        to_pay += pd.get('amount')

    attribs = $.extend(@model.toJSON(),{group: @group, to_pay: to_pay})

    $(@el).html(@ac_template(attribs))
