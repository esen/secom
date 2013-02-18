class Ort::Participant < ActiveRecord::Base
  devise :database_authenticatable, :timeoutable

  attr_accessible :name, :login

  has_many :cheques, :dependent => :nullify
  has_many :payments, :dependent => :nullify
  has_many :exams, :through => :cheques
  has_many :paid_exams, :through => :payments, :source => :exam

  validates_presence_of :name
  validate :password_valid?

  before_validation :generate_password
  before_save :encrypt_password

  attr_accessor :login, :password, :password_confirmation

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).joins(:cheques).where("ort_cheques.id = ?", login.to_i).first
    else
      where(conditions).first
    end
  end

  def generate_password
    self.password = SecureRandom.hex(8) if self.password.nil?
  end

  def encrypt_password
    self.encrypted_password = BCrypt::Password.create("#{password}#{self.class.pepper}", :cost => self.class.stretches).to_s
  end

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
