class Attendance < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  attr_accessible :attended, :course_id, :student_id, :checked_at

  scope :of_group, lambda { |group_id| where(:group_id => group_id) }
  scope :of_course, lambda { |course_id| where(:course_id => course_id) }
end
