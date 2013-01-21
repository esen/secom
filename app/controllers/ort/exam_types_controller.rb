class Ort::ExamTypesController < ApplicationController
  # GET /ort/exam_types
  # GET /ort/exam_types.json
  def index
    @ort_exam_types = Ort::ExamType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ort_exam_types }
    end
  end

  # GET /ort/exam_types/1
  # GET /ort/exam_types/1.json
  def show
    @ort_exam_type = Ort::ExamType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ort_exam_type }
    end
  end

  # GET /ort/exam_types/new
  # GET /ort/exam_types/new.json
  def new
    @ort_exam_type = Ort::ExamType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ort_exam_type }
    end
  end

  # GET /ort/exam_types/1/edit
  def edit
    @ort_exam_type = Ort::ExamType.find(params[:id])
  end

  # POST /ort/exam_types
  # POST /ort/exam_types.json
  def create
    @ort_exam_type = Ort::ExamType.new(params[:ort_exam_type])

    respond_to do |format|
      if @ort_exam_type.save
        format.html { redirect_to @ort_exam_type, notice: 'Exam type was successfully created.' }
        format.json { render json: @ort_exam_type, status: :created, location: @ort_exam_type }
      else
        format.html { render action: "new" }
        format.json { render json: @ort_exam_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ort/exam_types/1
  # PUT /ort/exam_types/1.json
  def update
    @ort_exam_type = Ort::ExamType.find(params[:id])

    respond_to do |format|
      if @ort_exam_type.update_attributes(params[:ort_exam_type])
        format.html { redirect_to @ort_exam_type, notice: 'Exam type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ort_exam_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ort/exam_types/1
  # DELETE /ort/exam_types/1.json
  def destroy
    @ort_exam_type = Ort::ExamType.find(params[:id])
    @ort_exam_type.destroy

    respond_to do |format|
      format.html { redirect_to ort_exam_types_url }
      format.json { head :no_content }
    end
  end
end
