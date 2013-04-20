Secom.Views.Lessons ||= {}

class Secom.Views.Lessons.IndexView extends Backbone.View
  template: JST["backbone/templates/lessons/index"]

  initialize: () ->
    @options.lessons.bind('reset', @addAll)

  addAll: () =>
    @options.lessons.each(@addOne)

  addOne: (lesson) =>
    view = new Secom.Views.Lessons.LessonView({model : lesson})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(lessons: @options.lessons.toJSON() ))
    @addAll()

    return this
