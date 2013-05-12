class Payment < ActiveRecord::Base
  belongs_to :student
  belongs_to :ort_participant, :class_name => 'Ort::Participant'
  belongs_to :source

  attr_accessible :amount, :note, :ort_participant_id, :source_id, :student_id, :payed_at

  validates_presence_of :amount

  scope :of_student, lambda { |student_id| where(:student_id => student_id) }
  scope :of_ort_participant, lambda { |ort_participant_id| where(:ort_participant_id => ort_participant_id) }
  scope :of_source, lambda { |source_id| where(:source_id => source_id) }
end
