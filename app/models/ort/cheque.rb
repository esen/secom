class Ort::Cheque < ActiveRecord::Base
  attr_accessible :mark, :exam, :participant

  belongs_to :participant
  belongs_to :exam

  validates_presence_of :participant_id, :exam_id
end
