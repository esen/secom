Secom.Views.Students ||= {}

class Secom.Views.Students.IndexView extends Backbone.View
  template: JST["backbone/templates/students/index"]
  with_payments_template: JST["backbone/templates/students/index_with_payments"]

  initialize: () ->
    @options.students.bind('reset', @addAll)

  addAll: () =>
    @options.students.each(@addOne)

  addOne: (student) =>
    view = new Secom.Views.Students.StudentView({model : student, groups: @options.groups, group: @options.group, payment_dates: @options.payment_dates, with_payments: @options.with_payments})
    @$("tbody").append(view.render().el)

  render: =>
    if (@options.with_payments)
      $(@el).html(@with_payments_template(group: @options.group))
      @addAll()
    else
      $(@el).html(@template(group: @options.group || null, student_num: @options.students.length))
      @addAll()

    return this
