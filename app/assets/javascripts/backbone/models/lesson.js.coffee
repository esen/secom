class Secom.Models.Lesson extends Backbone.Model
  paramRoot: 'lesson'

  defaults:
    title: null

class Secom.Collections.LessonsCollection extends Backbone.Collection
  model: Secom.Models.Lesson
  url: '/lessons'
