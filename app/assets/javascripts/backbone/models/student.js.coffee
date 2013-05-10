class Secom.Models.Student extends Backbone.Model
  paramRoot: 'student'

  defaults:
    name: null
    surname: null
    birth_date: null
    school: null
    address: null
    phone: null
    group_id: null
    discount: null
    started_at: null
    finished_at: null
    active: null

class Secom.Collections.StudentsCollection extends Backbone.Collection
  model: Secom.Models.Student
  url: '/students'
