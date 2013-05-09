Secom.Views.Groups ||= {}

class Secom.Views.Groups.ShowView extends Backbone.View
  template: JST["backbone/templates/groups/show"]

  events:
    "click .destroy" : "destroy"


  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    level = @options.levels.get(@model.get('level_id'))
    level = unless level
      '-'
    else
      level.get('name')

    attribs = $.extend(@model.toJSON(),{level: level})

    $(@el).html(@template(attribs))
    return this
