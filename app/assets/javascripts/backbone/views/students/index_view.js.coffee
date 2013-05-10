Secom.Views.Students ||= {}

class Secom.Views.Students.IndexView extends Backbone.View
  template: JST["backbone/templates/students/index"]

  initialize: () ->
    @options.students.bind('reset', @addAll)

  addAll: () =>
    @options.students.each(@addOne)

  addOne: (student) =>
    view = new Secom.Views.Students.StudentView({model : student, groups: @options.groups, show_groups: @options.show_groups})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(show_group: @options.show_groups, group: @options.group))
    @addAll()

    return this
