Secom.Views.Groups ||= {}

class Secom.Views.Groups.GroupView extends Backbone.View
  template: JST["backbone/templates/groups/group"]

  events: "click .destroy": "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Are you sure?'))
      @collection = @model.collection
      @model.destroy({
        success: (model, resp) =>
          if resp["status"] == "success"
            this.remove()
          else
            @collection.add(model)
            alert(resp["error"])
      })


    return false

  render: ->
    level = @options.levels.get(@model.get('level_id'))
    level = unless level
      '-'
    else
      level.get('name')

    attribs = $.extend(@model.toJSON(), {level: level})

    $(@el).html(@template(attribs))

    return this
