Secom.Views.Expenses ||= {}

class Secom.Views.Expenses.ExpenseView extends Backbone.View
  template: JST["backbone/templates/expenses/expense"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Чыгаша өчүрүлсүнбү?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    if router.holes
      hole = router.holes.get(@model.get('hole_id'))
      hole = unless hole
        '-'
      else
        hole.get('name')
    else
      hole = '-'

    if router.teachers
      teacher = router.teachers.get(@model.get('teacher_id'))
      teacher_name = unless teacher
        '-'
      else
        teacher.get('name')
    else
      teacher_name = '-'

    attribs = $.extend(@model.toJSON(),{hole: hole, teacher_name: teacher_name, teacher: @options.teacher})
    $(@el).html(@template(attribs))

    return this