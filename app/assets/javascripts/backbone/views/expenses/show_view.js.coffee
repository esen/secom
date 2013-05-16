Secom.Views.Expenses ||= {}

class Secom.Views.Expenses.ShowView extends Backbone.View
  template: JST["backbone/templates/expenses/show"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    if (confirm('Чыгаша өчүрүлсүнбү?'))
      @model.destroy()
      this.remove()
      if @options.teacher
        router.indexExpenses(@options.teacher.get('id'))
      else
        router.index()

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

    $(@el).html(@template($.extend(@model.toJSON(), {hole: hole, teacher_name: teacher_name, teacher: @options.teacher || null})))
    return this
