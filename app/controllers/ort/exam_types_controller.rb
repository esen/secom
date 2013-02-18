class Ort::ExamTypesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @exam_types = Ort::ExamType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exam_types }
    end
  end

  def show
    @exam_type = Ort::ExamType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exam_type }
    end
  end

  def new
    @exam_type = Ort::ExamType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exam_type }
    end
  end

  def edit
    @exam_type = Ort::ExamType.find(params[:id])
  end

  def create
    @exam_type = Ort::ExamType.new(params[:ort_exam_type])

    respond_to do |format|
      if @exam_type.save
        format.html { redirect_to @exam_type, notice: 'Exam type was successfully created.' }
        format.json { render json: @exam_type, status: :created, location: @exam_type }
      else
        format.html { render action: "new" }
        format.json { render json: @exam_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @exam_type = Ort::ExamType.find(params[:id])

    respond_to do |format|
      if @exam_type.update_attributes(params[:ort_exam_type])
        format.html { redirect_to @exam_type, notice: 'Exam type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @exam_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exam_type = Ort::ExamType.find(params[:id])

    begin
      @exam_type.destroy
    rescue
      flash[:error] = "Exam Type can not be deleted, because it has associated exams!"
    end

    redirect_to ort_exam_types_url
  end
end
