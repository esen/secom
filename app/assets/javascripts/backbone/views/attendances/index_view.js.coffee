Secom.Views.Attendances ||= {}

class Secom.Views.Attendances.IndexView extends Backbone.View
  template: JST["backbone/templates/attendances/index"]

  initialize: () ->
    @attendances = @options.attendances
    @attendances.bind('reset', @addAll)

  addAll: () =>
    @grouped_by_date = {}
    @attendances.each (attendance) =>
      checked_at = attendance.get('checked_at')
      @grouped_by_date[checked_at] = {} unless @grouped_by_date[checked_at]
      @grouped_by_date[checked_at][attendance.get('student_id')] = attendance.get('attended')

    console.log(@attendances)
    console.log(@grouped_by_date)

  addOne: (attendance) =>
    view = new Secom.Views.Attendances.AttendanceView({model : attendance})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(attendances: @attendances.toJSON() ))
    @addAll()

    return this
