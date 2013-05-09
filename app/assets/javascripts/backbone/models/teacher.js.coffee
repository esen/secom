class Secom.Models.Teacher extends Backbone.Model
  paramRoot: 'teacher'

  defaults:
    name: null
    surname: null
    phone: null
    address: null
    lesson_id: null

class Secom.Collections.TeachersCollection extends Backbone.Collection
  model: Secom.Models.Teacher
  url: '/teachers'
