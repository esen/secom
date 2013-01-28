module Ort::ChequesHelper
  def get_cheque_path(method)
    if @participant
      method == :show ? ort_participant_cheque_path(@participant, @cheque) : exams_ort_participant_path(@participant)
    elsif @exam
      method == :show ? ort_exam_cheque_path(@exam, @cheque) : participants_ort_exam_path(@exam)
    else
      method == :show ? ort_cheque_path(@cheque) : ort_participants_path
    end
  end
end
