class CourseTime < ActiveRecord::Base
  belongs_to :branch

  attr_accessible :ends_at, :starts_at, :branch_id
  validates_presence_of :starts_at, :ends_at, :branch_id

  validates_format_of :starts_at, :with => /^[012]\d:[012345]\d$/
  validates_format_of :ends_at, :with => /^[012]\d:[012345]\d$/

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end
