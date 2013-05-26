Secom.Views.Courses ||= {}

class Secom.Views.Courses.IndexView extends Backbone.View
  template: JST["backbone/templates/courses/index"]

  events:
    "click .new-course" : "new_course"

  initialize: () ->
    @courses = @options.courses
    @courses.bind('reset', @addAll)

  new_course: () =>
    this.remove()
    @view = new Secom.Views.Courses.NewView({collection : @courses, group : @options.group})
    $("#courses").html(@view.render().el)

  addAll: () =>
    @courses.each(@addOne)

  addOne: (course) =>
    view = new Secom.Views.Courses.CourseView({model : course, group : @options.group})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(courses: @courses.toJSON(), group: @options.group))
    @addAll()

    return this
