class Payment < ActiveRecord::Base
  belongs_to :branch
  belongs_to :student
  belongs_to :source

  attr_accessible :amount, :note, :ort_participant_id, :source_id, :student_id, :payed_at, :branch_id

  validates_presence_of :amount, :branch_id

  scope :of_student, lambda { |student_id| where(:student_id => student_id) }
  scope :of_source, lambda { |source_id| where(:source_id => source_id) }
  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end
