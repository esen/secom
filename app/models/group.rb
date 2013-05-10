class Group < ActiveRecord::Base
  belongs_to :level
  has_many :students, :dependent => :destroy

  attr_accessible :finished_at, :level_id, :name, :started_at, :active, :price
end
