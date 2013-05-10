Secom.Views.Students ||= {}

class Secom.Views.Students.StudentView extends Backbone.View
  template: JST["backbone/templates/students/student"]

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

    attribs = $.extend(@model.toJSON(),{show_group: true, group_name: group_name, group: @options.group || null})

    $(@el).html(@template(attribs))
    return this
