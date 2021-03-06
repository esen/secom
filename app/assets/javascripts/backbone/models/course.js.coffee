class Secom.Models.Course extends Backbone.Model
  paramRoot: 'course'

  defaults:
    group_id: null
    lesson_id: null
    course_time_id: null
    teacher_id: null
    room_id: null
    branch_id: null
    monday: null
    tuesday: null
    wednesday: null
    thursday: null
    friday: null
    saturday: null
    sunday: null
    dates: null
    group_name: null
    lesson_name: null
    room_name: null
    course_times: null

class Secom.Collections.CoursesCollection extends Backbone.Collection
  model: Secom.Models.Course
  url: '/courses'
