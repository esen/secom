class Secom.Models.Room extends Backbone.Model
  paramRoot: 'room'

  defaults:
    title: null
    capacity: null

class Secom.Collections.RoomsCollection extends Backbone.Collection
  model: Secom.Models.Room
  url: '/rooms'
