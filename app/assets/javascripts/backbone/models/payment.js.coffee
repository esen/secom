class Secom.Models.Payment extends Backbone.Model
  paramRoot: 'payment'

  defaults:
    student_id: null
    ort_participant_id: null
    source_id: null
    note: null
    amount: null

class Secom.Collections.PaymentsCollection extends Backbone.Collection
  model: Secom.Models.Payment
  url: '/payments'
