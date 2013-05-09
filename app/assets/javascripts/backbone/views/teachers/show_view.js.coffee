Secom.Views.Teachers ||= {}

class Secom.Views.Teachers.ShowView extends Backbone.View
  template: JST["backbone/templates/teachers/show"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    lesson = @options.lessons.get(@model.get('lesson_id'))
    lesson = unless lesson
      '-'
    else
      lesson.get('title')

    attribs = $.extend(@model.toJSON(),{lesson: lesson})

    $(@el).html(@template(attribs))
    return this
