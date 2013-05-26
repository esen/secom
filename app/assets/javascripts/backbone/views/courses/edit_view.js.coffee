Secom.Views.Courses ||= {}

class Secom.Views.Courses.EditView extends Backbone.View
  template : JST["backbone/templates/courses/edit"]

  events :
    "click .back" : "back"
    "submit #edit-course" : "update"

  back: () =>
    this.remove()
    $("#courses").html(router.c_view.render().el)

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (course) =>
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

  render : ->
    $(@el).html(@template(@model.toJSON() ))
    router.lessons.each(@addLesson)
    router.teachers.each(@addTeacher)
    router.course_times.each(@addCourseTime)
    router.rooms.each(@addRoom)

    this.$("form").backboneLink(@model)

    return this
