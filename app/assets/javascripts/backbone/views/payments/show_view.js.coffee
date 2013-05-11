Secom.Views.Payments ||= {}

class Secom.Views.Payments.ShowView extends Backbone.View
  template: JST["backbone/templates/payments/show"]

  events:
    "click .destroy": "destroy"

  destroy: () ->
    if (confirm('Киреше өчүрүлсүнбү?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    source = @options.sources.get(@model.get('source_id'))
    source = unless source
      '-'
    else
      source.get('name')

    attribs = $.extend(@model.toJSON(), {source: source})

    $(@el).html(@template(attribs))
    return this
