Secom.Views.Timetables ||= {}

class Secom.Views.Timetables.GeneralView extends Backbone.View
  template: JST["backbone/templates/timetables/general"]

  fillTable: (course_time) =>
    id = course_time.get('id')
    room_num = router.rooms.length

    @tr = $("<tr>")
    td = $("<td>")
    td.attr('rowspan', room_num)
    td.attr('style', 'font-weight: bold;')
    td.html(router.course_time_names[course_time.get('id')])
    @tr.append(td)

    router.rooms.each (room) =>
      td = $("<td>")
      td.attr('style', 'font-weight: bold;')
      td.html(room.get('title'))
      @tr.append(td)

      _(['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']).each (day) =>
        courses = []
        router.courses.select (c) ->
          if c.get('course_time_id') == id && c.get(day) && c.get('room_id') == room.get('id')
            courses.push c.get('group_name') + ' (' + router.lesson_names[c.get('lesson_id')] + ")<br/>" + router.teacher_names[c.get('teacher_id')]

        td = $("<td>")
        td.html(courses.join("<br/>"))
        @tr.append(td)

      @$("tbody").append(@tr)
      @tr = $("<tr>")

  render: =>
    $(@el).html(@template())
    router.course_times.each(@fillTable)

    return this
