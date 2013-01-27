class Ort::Participant < ActiveRecord::Base
  attr_accessible :name, :password

  has_many :cheques, :dependent => :nullify
  has_many :payments, :dependent => :nullify
  has_many :exams, :through => :cheques
  has_many :payed_exams, :through => :payments, :source => :exam

  validates_presence_of :name, :password

  before_create :generate_password

  def generate_password
    self.password = SecureRandom.hex(8)
  end

  def enrolled_exams

  end
end
