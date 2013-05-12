Secom.Views.Groups ||= {}

class Secom.Views.Groups.IndexView extends Backbone.View
  template: JST["backbone/templates/groups/index"]

  initialize: () ->
    @options.groups.bind('reset', @addAll)

  sort: (g) ->
    return g.get('level_id')

  addAll: () =>
    @options.groups.sortBy(@sort).forEach(@addOne)

  addOne: (group) =>
    view = new Secom.Views.Groups.GroupView({model: group, levels: @options.levels})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(groups: @options.groups.toJSON()))
    @addAll()

    return this
