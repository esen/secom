class Ort::Exam < ActiveRecord::Base
  attr_accessible :cost, :exam_type_id, :start_date

  belongs_to :exam_type

  has_many :cheques, :dependent => :nullify
  has_many :payments, :dependent => :nullify
  has_many :participants, :through => :cheques
  has_many :payed_participants, :through => :payments, :source => :participant

  delegate :name, :to => :exam_type

  validates_presence_of :exam_type
  validates_presence_of :start_date
end
