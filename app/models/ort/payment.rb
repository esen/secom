class Ort::Payment < ActiveRecord::Base
  belongs_to :branch
  belongs_to :participant
  belongs_to :exam

  attr_accessible :amount, :exam, :participant, :branch_id

  validates_presence_of :participant, :exam, :amount, :branch_id
  validates_numericality_of :amount

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end
