class CourseTime < ActiveRecord::Base
  attr_accessible :ends_at, :starts_at
  validates_presence_of :starts_at, :ends_at

  validates_format_of :starts_at, :with => /^[012]\d:[012345]\d$/
  validates_format_of :ends_at, :with => /^[012]\d:[012345]\d$/
end
