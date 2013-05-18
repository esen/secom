class Expense < ActiveRecord::Base
  belongs_to :branch
  belongs_to :teacher
  belongs_to :hole

  attr_accessible :amount, :hole_id, :note, :teacher_id, :expended_at, :branch_id

  validates_presence_of :amount, :branch_id

  scope :of_teacher, lambda { |teacher_id| where(:teacher_id => teacher_id) }
  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end
