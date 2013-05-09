Secom.Views.Teachers ||= {}

class Secom.Views.Teachers.TeacherView extends Backbone.View
  template: JST["backbone/templates/teachers/teacher"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    lesson = @options.lessons.get(@model.get('lesson_id'))
    lesson = unless lesson
      '-'
    else
      lesson.get('title')

    attribs = $.extend(@model.toJSON(),{lesson: lesson})

    $(@el).html(@template(attribs))
    return this
