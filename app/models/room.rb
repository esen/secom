class Room < ActiveRecord::Base
  belongs_to :branch

  attr_accessible :capacity, :title, :branch_id
  validates_presence_of :branch_id

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end
