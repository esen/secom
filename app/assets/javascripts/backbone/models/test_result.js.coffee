class Secom.Models.TestResult extends Backbone.Model
  paramRoot: 'test_result'

  defaults:
    student_id: null
    test_id: null
    mark: null

class Secom.Collections.TestResultsCollection extends Backbone.Collection
  model: Secom.Models.TestResult
  url: '/test_results'
