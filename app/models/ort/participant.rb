class Ort::Participant < ActiveRecord::Base
  attr_accessible :name

  has_many :cheques, :dependent => :nullify
  has_many :payments, :dependent => :nullify
  has_many :exams, :through => :cheques
  has_many :payed_exams, :through => :payments, :source => :exam

  validates_presence_of :name, :password
  validate :password_valid?

  before_validation :generate_password

  def generate_password
    self.password = SecureRandom.hex(8) if self.password.nil?
  end

  attr_accessor :password_confirmation

  def password_valid?
    if !password_confirmation.nil?
      self.errors.add(:password, "/ Confirmation mismatch") if password_confirmation != password
      self.errors.add(:password, "length must be in 5 - 10 range") unless password.length > 5 && password.length < 10
    end
  end

  def is_enrolled_to(exam)
    !self.cheques.where(:exam_id => exam.id).first.nil?
  end

  def has_payment_for(exam)
    self.payments.where(:exam_id => exam.id).count > 0
  end

  def paid_for(exam)
    self.payments.where(:exam_id => exam.id).collect { |p| p.amount }.inject(0) { |a, b| a += b }
  end
end
