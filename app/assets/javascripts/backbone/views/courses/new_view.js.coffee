Secom.Views.Courses ||= {}

class Secom.Views.Courses.NewView extends Backbone.View
  template: JST["backbone/templates/courses/new"]

  events:
    "click .back" : "back"
    "submit #new-course": "save"

  back: () =>
    this.remove()
    $("#courses").html(router.c_view.render().el)

  constructor: (options) ->
    super(options)
    first_lesson_id = router.lessons.first() && router.lessons.first().get('id') || null
    first_teacher_id = router.teachers.first() && router.teachers.first().get('id') || null
    first_course_time_id = router.course_times.first() && router.course_times.first().get('id') || null
    first_room_id = router.rooms.first() && router.rooms.first().get('id') || null
    @model = new @collection.model({lesson_id: first_lesson_id, teacher_id: first_teacher_id, course_time_id: first_course_time_id, room_id: first_room_id, group_id: @options.group.get('id')})

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (course) =>
        @model = course
        this.remove()
        group = @options.group
        router.indexCourses(group.get('id'), @model.collection)
        group.fetch(
          success: (group) ->
            $("#groups_capacity").html(group.get('capacity') || '-')
            $("#groups_courses").html(group.get('course_names').join("<br/>") || '-')
        )

      error: (course, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  addLesson: (lesson) =>
    view = new Secom.Views.Levels.OptionListView({model: lesson, selected_model_id: @model.get('lesson_id'), name: 'title'})
    @$("#lesson_id").append(view.render().el)

  addTeacher: (teacher) =>
    view = new Secom.Views.Levels.OptionListView({model: teacher, selected_model_id: @model.get('teacher_id'), name: 'name_surname'})
    @$("#teacher_id").append(view.render().el)

  addCourseTime: (course_time) =>
    view = new Secom.Views.Levels.OptionListView({model: course_time, selected_model_id: @model.get('course_time_id'), name: 'time'})
    @$("#course_time_id").append(view.render().el)

  addRoom: (room) =>
    view = new Secom.Views.Levels.OptionListView({model: room, selected_model_id: @model.get('room_id'), name: 'title'})
    @$("#room_id").append(view.render().el)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    router.lessons.each(@addLesson)
    router.teachers.each(@addTeacher)
    router.course_times.each(@addCourseTime)
    router.rooms.each(@addRoom)

    this.$("form").backboneLink(@model)

    return this
