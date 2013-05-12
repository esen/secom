class Secom.Models.Group extends Backbone.Model
  paramRoot: 'group'

  defaults:
    name: null
    level_id: null
    started_at: null
    finished_at: null
    active: null
    price: null
    to_pay: null

  is_valid: (payment_dates) ->
    valid = true
    total = 0

    if @get('started_at')
      payment_dates.forEach (pd) =>
        if pd.get('payment_date') < @get('started_at')
          valid = false
        total += pd.get('amount')
    else
      valid = false

    valid = false unless total == @get('price')

    return valid

class Secom.Collections.GroupsCollection extends Backbone.Collection
  model: Secom.Models.Group
  url: '/groups'
