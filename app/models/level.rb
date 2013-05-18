class Level < ActiveRecord::Base
  belongs_to :branch
  has_many :groups, :dependent => :nullify

  attr_accessible :name, :branch_id
  validates_presence_of :branch_id

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end