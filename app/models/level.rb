class Level < ActiveRecord::Base
  has_many :groups, :dependent => :nullify

  attr_accessible :name
end
