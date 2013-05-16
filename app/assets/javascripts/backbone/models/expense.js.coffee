class Secom.Models.Expense extends Backbone.Model
  paramRoot: 'expense'

  defaults:
    amount: null
    teacher_id: null
    hole_id: null
    note: null
    expended_at: null

class Secom.Collections.ExpensesCollection extends Backbone.Collection
  model: Secom.Models.Expense
  url: '/expenses'
