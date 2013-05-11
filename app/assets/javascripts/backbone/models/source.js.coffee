class Secom.Models.Source extends Backbone.Model
  paramRoot: 'source'

  defaults:
    name: null
    note: null

class Secom.Collections.SourcesCollection extends Backbone.Collection
  model: Secom.Models.Source
  url: '/sources'
