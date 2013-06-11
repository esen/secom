class Test < ActiveRecord::Base
  belongs_to :course
  has_many :test_results, :dependent => :destroy

  attr_accessible :course_id, :homework, :name, :test_date

  scope :of_course, lambda { |course_id| where(:course_id => course_id) }
end
