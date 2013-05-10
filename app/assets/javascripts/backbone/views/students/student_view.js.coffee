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
    if @options.show_groups
      group = @options.groups.get(@model.get('group_id'))
      group = unless group
        '-'
      else
        group.get('name')

      attribs = $.extend(@model.toJSON(),{show_group: true, group: group})
    else
      attribs = $.extend(@model.toJSON(),{show_group: null})

    $(@el).html(@template(attribs))
    return this
