Secom.Views.Groups ||= {}

class Secom.Views.Groups.IndexGroupedView extends Backbone.View
  template: JST["backbone/templates/groups/index_grouped"]

  addAll: () =>
    @options.levels.each(@addLevel)
    @options.groups.each(@addGroup)

  addLevel: (level) =>
    th = $(document.createElement('th'))
    th.html(level.get('name'))
    @$("thead").append(th)

    td = $(document.createElement('td'))
    td.attr('id', "level" + level.get('id'))
    @$("tbody").append(td)

  addGroup: (group) =>
    a = $(document.createElement('a'))
    a.attr('href', "#/" + group.get('id') + "/students/index")
    a.addClass('btn btn-small')
    a.html(group.get('name'))

    @$("#level" + group.get('level_id')).append(a)

  render: =>
    $(@el).html(@template())
    @addAll()

    return this
