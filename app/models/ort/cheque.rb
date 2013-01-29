class Ort::Cheque < ActiveRecord::Base
  attr_accessible :mark, :exam, :participant

  belongs_to :participant
  belongs_to :exam

  validates_presence_of :participant_id, :exam_id

  def total_paid
    Ort::Payment.where(:exam_id => self.exam_id, :participant_id => self.participant_id).sum(:amount).to_f
  end
end
