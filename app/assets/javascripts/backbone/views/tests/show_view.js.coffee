Secom.Views.Tests ||= {}

class Secom.Views.Tests.ShowView extends Backbone.View
  template: JST["backbone/templates/tests/show"]

  events:
    "click .destroy": "destroy"

  destroy: () ->
    if (confirm('Группа өчүрүлсүнбү?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    $(@el).html(@template($.extend(@model.toJSON(), {homework: @options.homework})))
    return this
