class Ort::Cheque < ActiveRecord::Base
  belongs_to :branch
  belongs_to :participant
  belongs_to :exam

  attr_accessible :mark, :exam, :participant, :branch_id

  validates_presence_of :participant_id, :exam_id, :branch_id

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }

  def total_paid
    Ort::Payment.where(:exam_id => self.exam_id, :participant_id => self.participant_id).sum(:amount).to_f
  end
end
