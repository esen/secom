class User < ActiveRecord::Base
  belongs_to :branch
  has_one :teacher

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable, :timeoutable

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :branch_id
  attr_accessible :name, :role, :email

  validates_presence_of :name, :role, :email, :username, :encrypted_password, :branch_id
  validates_uniqueness_of :username

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
