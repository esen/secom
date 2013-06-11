class Secom.Routers.TestResultsRouter extends Backbone.Router
  initialize: (options) ->
    @testResults = new Secom.Collections.TestResultsCollection()
    @testResults.reset options.testResults

  routes:
    "new"      : "newTestResult"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newTestResult: ->
    @view = new Secom.Views.TestResults.NewView(collection: @test_results)
    $("#test_results").html(@view.render().el)

  index: ->
    @view = new Secom.Views.TestResults.IndexView(test_results: @test_results)
    $("#test_results").html(@view.render().el)

  show: (id) ->
    test_result = @test_results.get(id)

    @view = new Secom.Views.TestResults.ShowView(model: test_result)
    $("#test_results").html(@view.render().el)

  edit: (id) ->
    test_result = @test_results.get(id)

    @view = new Secom.Views.TestResults.EditView(model: test_result)
    $("#test_results").html(@view.render().el)
