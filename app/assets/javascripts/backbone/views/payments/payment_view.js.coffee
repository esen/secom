Secom.Views.Payments ||= {}

class Secom.Views.Payments.PaymentView extends Backbone.View
  template: JST["backbone/templates/payments/payment"]

  events:
    "click .destroy" : "destroy"
    "click .edit"    : "edit"
    "submit #edit-payment" : "update"

  tagName: "tr"

  destroy: () ->
    if (confirm('Төлөм өчүрүлсүнбү?'))
      this.remove()
      @model.destroy()
      if router.student_view
        router.student_view.update_amounts()

    return false

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (payment) =>
        @model = payment
        @edit_view.remove()
        this.render()
        router.student_view.update_amounts()

      error: (payment, jqXHR) =>
        alert($.parseJSON(jqXHR.responseText).join(", "))
    )

  edit: () ->
    @edit_view = new Secom.Views.Payments.EditACView({model: @model})
    $(@el).html(@edit_view.render().el)

  render: ->
    if @options.sources
      source = @options.sources.get(@model.get('source_id'))
      source = unless source
        '-'
      else
        source.get('name')

    else
      source = null

    attribs = $.extend(@model.toJSON(),{source: source})
    $(@el).html(@template(attribs))

    return this
