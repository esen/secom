class Teacher < ActiveRecord::Base
  belongs_to :lesson

  attr_accessible :address, :lesson_id, :name, :phone, :surname
end
