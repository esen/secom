class Ort::ExamType < ActiveRecord::Base
  attr_accessible :cost, :name

  has_many :exams
end
