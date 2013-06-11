Secom.Views.Tests ||= {}

class Secom.Views.Tests.IndexView extends Backbone.View
  template: JST["backbone/templates/tests/index"]

  initialize: () ->
    @options.tests.bind('reset', @addAll)

  addAll: () =>
    @options.tests.each(@addOne)

  addOne: (test) =>
    view = new Secom.Views.Tests.TestView({model : test})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template($.extend(tests: @options.tests.toJSON(), {homework: @options.homework})))
    @addAll()

    return this
