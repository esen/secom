class Lesson < ActiveRecord::Base
  belongs_to :branch
  has_many :teachers, :dependent => :nullify

  attr_accessible :title, :branch_id
  validates_presence_of :branch_id

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end