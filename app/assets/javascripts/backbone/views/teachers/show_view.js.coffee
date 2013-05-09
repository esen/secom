Secom.Views.Teachers ||= {}

class Secom.Views.Teachers.ShowView extends Backbone.View
  template: JST["backbone/templates/teachers/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
