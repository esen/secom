Secom.Views.Groups ||= {}

class Secom.Views.Groups.EditView extends Backbone.View
  template : JST["backbone/templates/groups/edit"]

  events :
    "submit #edit-group" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (group) =>
        @model = group
        window.location.hash = "/#{@model.id}"
    )

  addLevel: (level) =>
    view = new Secom.Views.Levels.OptionListView({model: level, selected_model_id: @model.get('level_id')})
    @$("#level_id").append(view.render().el)

  render : ->
    $(@el).html(@template(@model.toJSON() ))
    @options.levels.each(@addLevel)


    this.$("form").backboneLink(@model)

    return this
