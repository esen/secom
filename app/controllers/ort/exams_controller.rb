class Ort::ExamsController < ApplicationController
  def index
    respond_to do |format|
      format.html {
        @exams = Ort::Exam.joins(:exam_type).select("ort_exams.*, ort_exam_types.name AS exam_name")
      }

      format.json {
        exams = Ort::Exam.where("ort_exams.start_date >= ?", Date.today)

        case params[:parameter]
          when "name" then
            @exams = exams.joins(:exam_type).where("ort_exam_types.name LIKE ?", "%#{params[:q]}%").group(:name).limit(10)
            @exams.collect! { |e| "#{e.name}" }
          when "date" then
            @exams = exams.where("start_date LIKE ?", "%#{params[:q]}%").group(:start_date).limit(10)
            @exams.collect! { |e| "#{e.start_date}" }
        end

        render json: @exams
      }
    end
  end

  def show
    @exam = Ort::Exam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exam }
    end
  end

  def new
    @exam = Ort::Exam.new
    @exam_types = Ort::ExamType.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exam }
    end
  end

  def edit
    @exam = Ort::Exam.find(params[:id])
    @exam_types = Ort::ExamType.all
  end

  def create
    @exam = Ort::Exam.new(params[:ort_exam])
    @exam.cost = @exam.exam_type.cost unless params[:set_cost].to_i == 1

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render json: @exam, status: :created, location: @exam }
      else
        @exam_types = Ort::ExamType.all
        format.html { render action: "new" }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @exam = Ort::Exam.find(params[:id])

    respond_to do |format|
      if @exam.update_attributes(params[:ort_exam])
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { head :no_content }
      else
        @exam_types = Ort::ExamType.all
        format.html { render action: "edit" }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exam = Ort::Exam.find(params[:id])
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to ort_exams_url }
      format.json { head :no_content }
    end
  end

  def participants
    @exam = Ort::Exam.find(params[:id])
    @cheques = @exam.cheques

    @payments = {}
    @exam.payments.group(:participant_id).select("ort_payments.participant_id, SUM(ort_payments.amount) AS amount").
        each { |e| @payments[e.participant_id] = e.amount }
  end
end
