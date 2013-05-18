class Ort::Exam < ActiveRecord::Base
  belongs_to :branch
  belongs_to :exam_type

  has_many :cheques, :dependent => :nullify
  has_many :payments, :dependent => :nullify
  has_many :participants, :through => :cheques
  has_many :paid_participants, :through => :payments, :source => :participant

  attr_accessible :cost, :exam_type_id, :start_date, :branch_id

  delegate :name, :to => :exam_type

  validates_presence_of :exam_type, :branch_id
  validates_presence_of :start_date

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end
