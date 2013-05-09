class Secom.Models.Group extends Backbone.Model
  paramRoot: 'group'

  defaults:
    name: null
    level_id: null
    started_at: null
    finished_at: null

class Secom.Collections.GroupsCollection extends Backbone.Collection
  model: Secom.Models.Group
  url: '/groups'
