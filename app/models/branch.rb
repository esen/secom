class Branch < ActiveRecord::Base
  has_many :course_times, :dependent => :restrict
  has_many :expenses, :dependent => :restrict
  has_many :groups, :dependent => :restrict
  has_many :holes, :dependent => :restrict
  has_many :lessons, :dependent => :restrict
  has_many :levels, :dependent => :restrict
  has_many :ort_cheques, :class_name => 'Ort::Cheque', :dependent => :restrict
  has_many :ort_exam_types, :class_name => 'Ort::ExamType', :dependent => :restrict
  has_many :ort_exams, :class_name => 'Ort::Exam', :dependent => :restrict
  has_many :ort_participants, :class_name => 'Ort::Participant', :dependent => :restrict
  has_many :payment_dates, :dependent => :restrict
  has_many :payments, :dependent => :restrict
  has_many :rooms, :dependent => :restrict
  has_many :sources, :dependent => :restrict
  has_many :students, :dependent => :restrict
  has_many :teachers, :dependent => :restrict
  has_many :users, :dependent => :restrict

  attr_accessible :address, :name
end
