class Ort::Exam < ActiveRecord::Base
  attr_accessible :cost, :exam_type1, :exam_type2_id, :exam_type3_id, :exam_type4_id, :exam_type5_id

  belongs_to :exam_type1, :class_name => "Ort::ExamType", :foreign_key => :exam_type1_id
  belongs_to :exam_type2, :class_name => "Ort::ExamType", :foreign_key => :exam_type2_id
  belongs_to :exam_type3, :class_name => "Ort::ExamType", :foreign_key => :exam_type3_id
  belongs_to :exam_type4, :class_name => "Ort::ExamType", :foreign_key => :exam_type4_id
  belongs_to :exam_type5, :class_name => "Ort::ExamType", :foreign_key => :exam_type5_id

  has_many :cheques, :dependent => :nullify
  has_many :payments, :dependent => :nullify
  has_many :participants, :through => :cheques
  has_many :payed_participants, :through => :payments, :source => :participant

  def exam_types
    exam_types = []
    exam_types << exam_type1 if exam_type1
    exam_types << exam_type2 if exam_type2
    exam_types << exam_type3 if exam_type3
    exam_types << exam_type4 if exam_type4
    exam_types << exam_type5 if exam_type5
    exam_types
  end

  validates_presence_of :exam_type1

end
