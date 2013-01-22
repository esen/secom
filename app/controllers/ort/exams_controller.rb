class Ort::ExamsController < ApplicationController
  def index
    @exams = Ort::Exam.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exams }
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
    @exam_types = Ort::ExamType.all

    @exam.cost = @exam.total_cost unless params[:set_cost].to_i == 1

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render json: @exam, status: :created, location: @exam }
      else
        format.html { render action: "new" }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    puts params[:ort_exam]
    @exam = Ort::Exam.find(params[:id])
    @exam_types = Ort::ExamType.all

    respond_to do |format|
      if @exam.update_attributes(params[:ort_exam])
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { head :no_content }
      else
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
end
