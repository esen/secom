Secom.Views.CourseTimes ||= {}

class Secom.Views.CourseTimes.IndexView extends Backbone.View
  template: JST["backbone/templates/course_times/index"]

  initialize: () ->
    @options.course_times.bind('reset', @addAll)

  addAll: () =>
    @options.course_times.each(@addOne)

  addOne: (course_time) =>
    unless course_time.isNew()
      view = new Secom.Views.CourseTimes.CourseTimeView({model : course_time})
      @$("tbody").append(view.render().el)
    else
      @options.course_times
      @options.course_times.remove(course_time)

  render: =>
    $(@el).html(@template(course_times: @options.course_times.toJSON() ))
    @addAll()

    return this
