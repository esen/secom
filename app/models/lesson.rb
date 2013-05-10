class Lesson < ActiveRecord::Base
  has_many :teachers, :dependent => :nullify

  attr_accessible :title
end
