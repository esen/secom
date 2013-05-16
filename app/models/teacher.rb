class Teacher < ActiveRecord::Base
  belongs_to :lesson
  has_many :expenses

  attr_accessible :address, :lesson_id, :name, :phone, :surname
end
