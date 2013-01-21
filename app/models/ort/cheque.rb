class Ort::Cheque < ActiveRecord::Base
  attr_accessible :mark1, :mark2, :mark3, :mark4, :mark5, :exam, :participant

  belongs_to :participant
  belongs_to :exam

  validates_presence_of :participant
  validates_presence_of :exam
end
