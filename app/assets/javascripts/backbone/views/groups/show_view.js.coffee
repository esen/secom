Secom.Views.Groups ||= {}

class Secom.Views.Groups.ShowView extends Backbone.View
  template: JST["backbone/templates/groups/show"]

  events:
    "click .destroy": "destroy"
    "click #activate_group": "activate"
    "click #deactivate_group": "deactivate"


  destroy: () ->
    if (confirm('Группа өчүрүлсүнбү?'))
      @model.destroy()
      this.remove()
      router.index()

  handle_response: (resp, status, xhr) =>
    status = resp["status"]
    group = resp["group"]
    error = resp["error"]
    if status == "success"
      @model.set(group)
      this.remove()
      router.show(@model.get('id'))
    else
      alert(error)

  activate: () ->
    if @model.is_valid(router.payment_dates)
      $.get(@model.collection.url + "/#{@model.get('id')}/activate", "", @handle_response, 'json')
    else
      router.pd_view.remove() if router.pd_view
      router.showPaymentDatesGenerate(@model.get('id'))

  deactivate: () ->
    $.get(@model.collection.url + "/#{@model.get('id')}/deactivate", "", @handle_response, 'json')

  render: ->
    level = @options.levels.get(@model.get('level_id'))
    level = unless level
      '-'
    else
      level.get('name')

    attribs = $.extend(@model.toJSON(), {level: level})

    $(@el).html(@template(attribs))
    return this
