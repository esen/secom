class Secom.Routers.GroupsRouter extends Backbone.Router
  initialize: (options) ->
    @groups = new Secom.Collections.GroupsCollection()
    @groups.reset options.groups
    @levels = new Secom.Collections.LevelsCollection()
    @levels.reset options.levels

  routes:
    "new"      : "newGroup"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newGroup: ->
    @view = new Secom.Views.Groups.NewView(collection: @groups, levels: @levels)
    $("#groups").html(@view.render().el)

  index: ->
    @view = new Secom.Views.Groups.IndexView(groups: @groups, levels: @levels)
    $("#groups").html(@view.render().el)

  show: (id) ->
    group = @groups.get(id)

    @view = new Secom.Views.Groups.ShowView(model: group, levels: @levels)
    $("#groups").html(@view.render().el)

  edit: (id) ->
    group = @groups.get(id)

    @view = new Secom.Views.Groups.EditView(model: group, levels: @levels)
    $("#groups").html(@view.render().el)
