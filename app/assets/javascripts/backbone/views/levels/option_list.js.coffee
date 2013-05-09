Secom.Views.Levels ||= {}

class Secom.Views.Levels.OptionListView extends Backbone.View
  template: JST["backbone/templates/levels/option_list"]

  tagName: "option"

  render: ->
    $(@el).html(@template(@model.toJSON()))
    $(@el).val(@model.get('id'))
    if @options.selected_model_id == @model.get('id')
      $(@el).attr('selected', 'true')

    return this
