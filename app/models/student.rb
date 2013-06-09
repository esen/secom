class Student < ActiveRecord::Base
  belongs_to :branch
  belongs_to :group

  has_many :payments, :dependent => :restrict
  has_many :attendances, :dependent => :destroy

  attr_accessible :active, :address, :birth_date, :discount, :finished_at, :group_id, :name, :phone, :school, :started_at, :surname, :branch_id
  validates_presence_of :name, :group, :branch_id

  scope :of_group, lambda { |group_id| where(:group_id => group_id) }
  scope :not_finished, where(:finished_at => nil)
  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
end
