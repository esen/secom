class Lesson < ActiveRecord::Base
  has_many :teachers

  attr_accessible :title
end
