class Expense < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :hole

  attr_accessible :amount, :hole_id, :note, :teacher_id, :expended_at

  validates_presence_of :amount

  scope :of_teacher, lambda { |teacher_id| where(:teacher_id => teacher_id) }
end
