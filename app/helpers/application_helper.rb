module ApplicationHelper
  def get_path(class_name, method, object = nil)
    path_method = class_name.to_s
    path_method += "s"

    if @participant
      path_method = "participants/#{@participant.id}/" + path_method
    elsif @exam
      path_method = "exams/#{@exam.id}/" + path_method
    elsif @cheque && class_name != :cheque
      path_method = "cheques/#{@cheque.id}/" + path_method
    end

    path_method += "/" + object.id.to_s if [:show, :edit, :destroy].include? method
    path_method += "/" + method.to_s if [:new, :edit].include? method

    path_method = "/ort/" + path_method
    path_method
  end
end
