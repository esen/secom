class Ort::ExamType < ActiveRecord::Base
  attr_accessible :cost, :name

  def exams
    Ort::Exam.where("exam_type1_id = ? OR exam_type2_id = ? OR exam_type3_id = ? OR exam_type4_id = ? OR exam_type5_id = ?",
                    self.id, self.id, self.id, self.id, self.id)
  end
end
