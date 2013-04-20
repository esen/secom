class Secom.Routers.CourseTimesRouter extends Backbone.Router
  initialize: (options) ->
    @course_times = new Secom.Collections.CourseTimesCollection()
    @course_times.reset options.course_times

  routes:
    "new"      : "newCourseTime"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newCourseTime: ->
    @view = new Secom.Views.CourseTimes.NewView(collection: @course_times)
    $("#course_times").html(@view.render().el)

  index: ->
    @view = new Secom.Views.CourseTimes.IndexView(course_times: @course_times)
    $("#course_times").html(@view.render().el)

  show: (id) ->
    course_time = @course_times.get(id)

    @view = new Secom.Views.CourseTimes.ShowView(model: course_time)
    $("#course_times").html(@view.render().el)

  edit: (id) ->
    course_time = @course_times.get(id)

    @view = new Secom.Views.CourseTimes.EditView(model: course_time, orig_values: {starts_at: course_time.get("starts_at"), ends_at: course_time.get("ends_at")})
    $("#course_times").html(@view.render().el)
