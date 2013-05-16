class Hole < ActiveRecord::Base
  has_many :expenses

  attr_accessible :name, :note
end
