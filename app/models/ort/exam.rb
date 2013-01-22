class Ort::Exam < ActiveRecord::Base
  attr_accessible :cost, :exam_types, :start_date

  belongs_to :exam_type1, :class_name => "Ort::ExamType", :foreign_key => :exam_type1_id
  belongs_to :exam_type2, :class_name => "Ort::ExamType", :foreign_key => :exam_type2_id
  belongs_to :exam_type3, :class_name => "Ort::ExamType", :foreign_key => :exam_type3_id
  belongs_to :exam_type4, :class_name => "Ort::ExamType", :foreign_key => :exam_type4_id
  belongs_to :exam_type5, :class_name => "Ort::ExamType", :foreign_key => :exam_type5_id

  has_many :cheques, :dependent => :nullify
  has_many :payments, :dependent => :nullify
  has_many :participants, :through => :cheques
  has_many :payed_participants, :through => :payments, :source => :participant

  delegate :name, :to => :exam_type1

  validates_presence_of :exam_type1
  validates_presence_of :start_date

  def exam_types
    exam_types = []
    exam_types << exam_type1 if exam_type1
    exam_types << exam_type2 if exam_type2
    exam_types << exam_type3 if exam_type3
    exam_types << exam_type4 if exam_type4
    exam_types << exam_type5 if exam_type5
    exam_types
  end

  def exam_types=(ets)
    i = 0
    ets.each do |et|
      exam_type = Ort::ExamType.find(et.to_i) rescue nil
      if exam_type
        i += 1
        break if i > 5
        self.send("exam_type#{i}=", exam_type)
      end
    end
  end

  def total_cost
    exam_types.collect { |et| et.cost }.inject(0) { |a, b| a = a + b }
  end
end
