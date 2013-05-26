Secom.Views.Levels ||= {}

class Secom.Views.Levels.OptionListView extends Backbone.View
  tagName: "option"

  render: ->
    name = switch @options.name
      when 'title'
        @model.get('title')
      when 'name_surname'
        @model.get('name') + " " + @model.get('surname')
      when 'time'
        @model.get('starts_at') + ' - ' + @model.get('ends_at')
      else
        @model.get('name')

    $(@el).html(name)
    $(@el).val(@model.get('id'))
    if @options.selected_model_id == @model.get('id')
      $(@el).attr('selected', 'true')

    return this
