class Secom.Routers.TimetableRouter extends Backbone.Router
  initialize: (options) ->
    @course_times = new Secom.Collections.CourseTimesCollection()
    @course_times.reset options.course_times
    @lessons = new Secom.Collections.LessonsCollection()
    @lessons.reset options.lessons
    @teachers = new Secom.Collections.TeachersCollection()
    @teachers.reset options.teachers
    @rooms = new Secom.Collections.RoomsCollection()
    @rooms.reset options.rooms
    @courses = new Secom.Collections.CoursesCollection()
    @courses.reset options.courses

    @lesson_names = {}
    @lessons.each (l) =>
      @lesson_names[l.get('id')] = l.get('title').substr(0, 3)

    @teacher_names = {}
    @teachers.each (l) =>
      surname = if l.get('surname') then l.get('surname').substr(0, 7) else ''
      name = if l.get('name') then l.get('name').substr(0, 7) else ''
      @teacher_names[l.get('id')] = surname + " " + name + '.'

    @room_names = {}
    @rooms.each (l) =>
      @room_names[l.get('id')] = l.get('title')

    @course_time_names = {}
    @course_times.each (l) =>
      @course_time_names[l.get('id')] = l.get('starts_at') + ' ' + l.get('ends_at')

  routes:
    ".*"           : "general"
    "teacher"      : "by_teacher"
    "room"         : "by_room"
    "group"        : "by_group"

  general: () ->
    view = new Secom.Views.Timetables.GeneralView()
    $("#main_table").html(view.render().el)