class Secom.Models.Level extends Backbone.Model
  paramRoot: 'level'

  defaults:
    name: null

class Secom.Collections.LevelsCollection extends Backbone.Collection
  model: Secom.Models.Level
  url: '/levels'
