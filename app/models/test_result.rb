class TestResult < ActiveRecord::Base
  belongs_to :student
  belongs_to :test

  attr_accessible :mark, :student_id, :test_id

  scope :of_student, lambda { |student_id| where(:student_id => student_id) }
  scope :of_test, lambda { |test_id| where(:test_id => test_id) }
end
