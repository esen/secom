class Source < ActiveRecord::Base
  has_many :payments, :dependent => :nullify

  attr_accessible :name, :note
end
