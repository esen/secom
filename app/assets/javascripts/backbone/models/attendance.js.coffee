class Secom.Models.Attendance extends Backbone.Model
  paramRoot: 'attendance'

  defaults:
    branch_id: null
    student_id: null
    course_id: null
    attended: null
    checked_at: null

class Secom.Collections.AttendancesCollection extends Backbone.Collection
  model: Secom.Models.Attendance
  url: '/attendances'
