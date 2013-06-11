Secom.Views.TestResults ||= {}

class Secom.Views.TestResults.IndexView extends Backbone.View
  template: JST["backbone/templates/test_results/index"]

  initialize: () ->
    @options.testResults.bind('reset', @addAll)

  addAll: () =>
    @options.testResults.each(@addOne)

  addOne: (testResult) =>
    view = new Secom.Views.TestResults.TestResultView({model : testResult})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(testResults: @options.testResults.toJSON() ))
    @addAll()

    return this
