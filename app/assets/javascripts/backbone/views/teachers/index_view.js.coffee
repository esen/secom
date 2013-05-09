Secom.Views.Teachers ||= {}

class Secom.Views.Teachers.IndexView extends Backbone.View
  template: JST["backbone/templates/teachers/index"]

  initialize: () ->
    @options.teachers.bind('reset', @addAll)

  addAll: () =>
    @options.teachers.each(@addOne)

  addOne: (teacher) =>
    view = new Secom.Views.Teachers.TeacherView({model : teacher})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(teachers: @options.teachers.toJSON() ))
    @addAll()

    return this
