Secom.Views.Students ||= {}

class Secom.Views.Students.StudentView extends Backbone.View
  template: JST["backbone/templates/students/student"]
  with_payments_template: JST["backbone/templates/students/student_with_payments"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    unless @options.group
      group_name = @options.groups.get(@model.get('group_id')).get('name')

    if (@options.with_payments)
      to_pay = @options.group.get('to_pay') - @model.get('discount')
      attribs = $.extend(@model.toJSON(),{group_name: group_name, group: @options.group, to_pay: to_pay})
      $(@el).html(@with_payments_template(attribs))
    else
      attribs = $.extend(@model.toJSON(),{group_name: group_name, group: @options.group || null})
      $(@el).html(@template(attribs))

    return this
