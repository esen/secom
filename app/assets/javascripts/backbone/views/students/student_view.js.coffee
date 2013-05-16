Secom.Views.Students ||= {}

class Secom.Views.Students.StudentView extends Backbone.View
  template: JST["backbone/templates/students/student"]
  with_payments_template: JST["backbone/templates/students/student_with_payments"]

  events:
    "click .destroy"    : "destroy"
    "click .activate"   : "activate"
    "click .deactivate" : "deactivate"

  activate: () ->
    $.get(@model.collection.url + "/#{@model.get('id')}/activate", "", @handle_response, 'json')

  deactivate: () ->
    $.get(@model.collection.url + "/#{@model.get('id')}/deactivate", "", @handle_response, 'json')

  handle_response: (resp, status, xhr) =>
    status = resp["status"]
    student = resp["student"]
    error = resp["error"]
    if status == "success"
      @model.set(student)
      this.render()
    else
      alert(error)

  tagName: "tr"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    unless @options.group
      group_name = @options.groups.get(@model.get('group_id')).get('name')

    if (@options.with_payments)
      to_pay = 0
      student_started_at = @model.get('started_at')
      @options.payment_dates.forEach (pd) =>
        if student_started_at
          if student_started_at <= pd.get('payment_date') <= today
            to_pay += pd.get('amount')
        else
          if pd.get('payment_date') <= today
            to_pay += pd.get('amount')

      to_pay = to_pay - @model.get('discount')
      attribs = $.extend(@model.toJSON(),{group_name: group_name, group: @options.group, to_pay: to_pay})
      $(@el).html(@with_payments_template(attribs))
    else
      attribs = $.extend(@model.toJSON(),{group_name: group_name, group: @options.group || null})
      $(@el).html(@template(attribs))

    return this
