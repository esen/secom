class Student < ActiveRecord::Base
  belongs_to :group
  has_many :payments, :dependent => :restirct

  attr_accessible :active, :address, :birth_date, :discount, :finished_at, :group_id, :name, :phone, :school, :started_at, :surname
  validates_presence_of :name, :group

  scope :of_group, lambda { |group_id| where(:group_id => group_id) }
end
