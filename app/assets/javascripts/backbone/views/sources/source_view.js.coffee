Secom.Views.Sources ||= {}

class Secom.Views.Sources.SourceView extends Backbone.View
  template: JST["backbone/templates/sources/source"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
