Secom.Views.Groups ||= {}

class Secom.Views.Groups.NewView extends Backbone.View
  template: JST["backbone/templates/groups/new"]

  events:
    "submit #new-group": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model({level_id: @options.levels.first().get('id')})

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (group) =>
        @model = group
        window.location.hash = "/#{@model.id}"

      error: (group, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  addLevel: (level) =>
    view = new Secom.Views.Levels.OptionListView({model: level, selected_model_id: @model.get('level_id')})
    @$("#level_id").append(view.render().el)

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    @options.levels.each(@addLevel)

    this.$("form").backboneLink(@model)

    return this
