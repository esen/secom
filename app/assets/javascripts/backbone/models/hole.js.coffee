class Secom.Models.Hole extends Backbone.Model
  paramRoot: 'hole'

  defaults:
    name: null
    note: null

class Secom.Collections.HolesCollection extends Backbone.Collection
  model: Secom.Models.Hole
  url: '/holes'
