Secom.Views.Courses ||= {}

class Secom.Views.Courses.IndexWithDetailsView extends Backbone.View
  template: JST["backbone/templates/courses/index_with_details"]
  course_template: JST["backbone/templates/courses/course_with_details"]

  addAll: () =>
    @options.courses.each(@addCourse)

  addCourse: (course) =>
    days = []
    days.push 'ДШ' if course.get('monday')
    days.push 'ШШ' if course.get('tuesday')
    days.push 'ШР' if course.get('wednesday')
    days.push 'БШ' if course.get('thursday')
    days.push 'ЖМ' if course.get('friday')
    days.push 'ИШ' if course.get('saturday')
    days.push 'ЖК' if course.get('sunday')

    tr = $("<tr>")
    tr.html(@course_template($.extend(course.toJSON(), {days: days.join(" ")})))

    @$("tbody").append(tr)

  render: =>
    $(@el).html(@template())
    @addAll()

    return this
