class Hole < ActiveRecord::Base
  belongs_to :branch
  has_many :expenses

  attr_accessible :name, :note, :branch_id
  validates_presence_of :branch_id

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end
