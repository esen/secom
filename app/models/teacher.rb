class Teacher < ActiveRecord::Base
  belongs_to :branch
  belongs_to :lesson
  has_many :expenses
  has_many :courses, :dependent => :nullify

  attr_accessible :address, :lesson_id, :name, :phone, :surname, :branch_id
  validates_presence_of :branch_id

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end
