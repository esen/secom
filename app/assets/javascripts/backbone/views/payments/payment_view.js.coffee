Secom.Views.Payments ||= {}

class Secom.Views.Payments.PaymentView extends Backbone.View
  template: JST["backbone/templates/payments/payment"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    source = @options.sources.get(@model.get('source_id'))
    source = unless source
      '-'
    else
      source.get('name')

    attribs = $.extend(@model.toJSON(),{source: source})

    $(@el).html(@template(attribs))

    return this
