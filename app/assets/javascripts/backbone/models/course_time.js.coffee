class Secom.Models.CourseTime extends Backbone.Model
  paramRoot: 'course_time'

  defaults:
    starts_at: null
    ends_at: null

class Secom.Collections.CourseTimesCollection extends Backbone.Collection
  model: Secom.Models.CourseTime
  url: '/course_times'
