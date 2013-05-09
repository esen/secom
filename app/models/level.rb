class Level < ActiveRecord::Base
  has_many :groups

  attr_accessible :name
end
