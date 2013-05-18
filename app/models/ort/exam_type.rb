class Ort::ExamType < ActiveRecord::Base
  belongs_to :branch
  has_many :exams, :dependent => :restrict

  attr_accessible :cost, :name, :branch_id
  validates_presence_of :branch_id

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end
