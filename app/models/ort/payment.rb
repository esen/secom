class Ort::Payment < ActiveRecord::Base
  attr_accessible :amount, :exam, :participant

  belongs_to :participant
  belongs_to :exam

  validates_presence_of :participant
  validates_presence_of :exam
end
