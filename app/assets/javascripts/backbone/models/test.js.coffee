class Secom.Models.Test extends Backbone.Model
  paramRoot: 'test'

  defaults:
    name: null
    test_date: null
    homework: null
    course_id: null
    group_name: null
    course_name: null

class Secom.Collections.TestsCollection extends Backbone.Collection
  model: Secom.Models.Test
  url: '/tests'
