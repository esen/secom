class Secom.Models.PaymentDate extends Backbone.Model
  paramRoot: 'payment_date'

  defaults:
    group_id: null
    payment_date: null
    amount: null

class Secom.Collections.PaymentDatesCollection extends Backbone.Collection
  model: Secom.Models.PaymentDate
  url: '/payment_dates'

  total_amount: ->
    total = 0

    @forEach (pd) ->
      total += parseInt(pd.get('amount'))

    return total
