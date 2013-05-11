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

  activate: () ->
    if @model.is_valid(router.payment_dates)
      @model.set('active', true)
      @model.save(null,
        success : (group) =>
          @model = group
          this.remove()
          router.show(@model.get('id'))
      )
    else
      router.pd_view.remove() if router.pd_view
      router.showPaymentDatesGenerate(@model.get('id'))

  deactivate: () ->
    @model.set('active', false)
    @model.save(null,
      success : (group) =>
        @model = group
        this.remove()
        router.show(@model.get('id'))
    )

  render: ->
    level = @options.levels.get(@model.get('level_id'))
    level = unless level
      '-'
    else
      level.get('name')

    attribs = $.extend(@model.toJSON(), {level: level})

    $(@el).html(@template(attribs))
    return this
