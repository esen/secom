class Ort::ExamsController < ApplicationController
  # GET /ort/exams
  # GET /ort/exams.json
  def index
    @ort_exams = Ort::Exam.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ort_exams }
    end
  end

  # GET /ort/exams/1
  # GET /ort/exams/1.json
  def show
    @ort_exam = Ort::Exam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ort_exam }
    end
  end

  # GET /ort/exams/new
  # GET /ort/exams/new.json
  def new
    @ort_exam = Ort::Exam.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ort_exam }
    end
  end

  # GET /ort/exams/1/edit
  def edit
    @ort_exam = Ort::Exam.find(params[:id])
  end

  # POST /ort/exams
  # POST /ort/exams.json
  def create
    @ort_exam = Ort::Exam.new(params[:ort_exam])

    respond_to do |format|
      if @ort_exam.save
        format.html { redirect_to @ort_exam, notice: 'Exam was successfully created.' }
        format.json { render json: @ort_exam, status: :created, location: @ort_exam }
      else
        format.html { render action: "new" }
        format.json { render json: @ort_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ort/exams/1
  # PUT /ort/exams/1.json
  def update
    @ort_exam = Ort::Exam.find(params[:id])

    respond_to do |format|
      if @ort_exam.update_attributes(params[:ort_exam])
        format.html { redirect_to @ort_exam, notice: 'Exam was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ort_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ort/exams/1
  # DELETE /ort/exams/1.json
  def destroy
    @ort_exam = Ort::Exam.find(params[:id])
    @ort_exam.destroy

    respond_to do |format|
      format.html { redirect_to ort_exams_url }
      format.json { head :no_content }
    end
  end
end
