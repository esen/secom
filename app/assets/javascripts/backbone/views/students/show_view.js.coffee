Secom.Views.Students ||= {}

class Secom.Views.Students.ShowView extends Backbone.View
  template: JST["backbone/templates/students/show"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    group = @options.groups.get(@model.get('group_id'))
    group = unless group
      '-'
    else
      group.get('name')

    attribs = $.extend(@model.toJSON(),{group: group})

    $(@el).html(@template(attribs))
    return this
