Secom.Views.Courses ||= {}

class Secom.Views.Courses.CourseView extends Backbone.View
  template: JST["backbone/templates/courses/course"]

  events:
    "click .edit" : "edit"
    "click .destroy" : "destroy"

  tagName: "tr"

  edit: () =>
    router.c_view.remove()
    @edit_view = new Secom.Views.Courses.EditView({model: @model, group : @options.group})
    $("#courses").html(@edit_view.render().el)

  destroy: () ->
    if (confirm("Предмет өчүрүлсүбү?"))
      @model.destroy()
      this.remove()
      @options.group.fetch(
        success: (group) ->
          $("#groups_capacity").html(group.get('capacity') || '-')
          $("#groups_courses").html(group.get('course_names').join("<br/>") || '-')
      )

    return false

  render: ->
    lesson = router.lessons.get(@model.get('lesson_id'))
    course_time = router.course_times.get(@model.get('course_time_id'))
    teacher = router.teachers.get(@model.get('teacher_id'))
    room = router.rooms.get(@model.get('room_id'))

    lesson = if lesson then lesson.get('title') else '-'
    course_time = if course_time then (course_time.get('starts_at') + " - " + course_time.get('ends_at')) else '-'
    teacher = if teacher then teacher.get('name') + " " + teacher.get('surname') else '-'
    room = if room then room.get('title') else '-'

    days = []
    days.push 'ДШ' if @model.get('monday')
    days.push 'ШШ' if @model.get('tuesday')
    days.push 'ШР' if @model.get('wednesday')
    days.push 'БШ' if @model.get('thursday')
    days.push 'ЖМ' if @model.get('friday')
    days.push 'ИШ' if @model.get('saturday')
    days.push 'ЖК' if @model.get('sunday')

    attribs = $.extend(@model.toJSON(), {group: @options.group, lesson: lesson, course_time: course_time, teacher: teacher, room: room, days: days.join(' ')})
    $(@el).html(@template(attribs))
    return this
