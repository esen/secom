Secom.Views.Students ||= {}

class Secom.Views.Students.IndexView extends Backbone.View
  template: JST["backbone/templates/students/index"]

  initialize: () ->
    @options.students.bind('reset', @addAll)

  addAll: () =>
    @options.students.each(@addOne)

  addOne: (student) =>
    view = new Secom.Views.Students.StudentView({model : student, groups: @options.groups, group: @options.group})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(group: @options.group || null))
    @addAll()

    return this
