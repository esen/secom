Secom.Views.Students ||= {}

class Secom.Views.Students.ShowView extends Backbone.View
  template: JST["backbone/templates/students/show"]
  ac_template: JST["backbone/templates/students/show_ac"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    if ur == 'ad' && (confirm('Are you sure?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    group = @options.groups.get(@model.get('group_id'))
    group_name = unless group
      '-'
    else
      group.get('name')

    switch ur
      when 'ac'
        attribs = $.extend(@model.toJSON(),{group: group})

        $(@el).html(@ac_template(attribs))
      else
        attribs = $.extend(@model.toJSON(),{group_name: group_name, group: @options.group || null})

        $(@el).html(@template(attribs))

    return this
