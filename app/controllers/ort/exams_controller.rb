class Ort::ExamsController < ApplicationController
  # GET /ort/exams
  # GET /ort/exams.json
  def index
    @exams = Ort::Exam.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exams }
    end
  end

  # GET /ort/exams/1
  # GET /ort/exams/1.json
  def show
    @exam = Ort::Exam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exam }
    end
  end

  # GET /ort/exams/new
  # GET /ort/exams/new.json
  def new
    @exam = Ort::Exam.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exam }
    end
  end

  # GET /ort/exams/1/edit
  def edit
    @exam = Ort::Exam.find(params[:id])
  end

  # POST /ort/exams
  # POST /ort/exams.json
  def create
    @exam = Ort::Exam.new(params[:ort_exam])

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

  # PUT /ort/exams/1
  # PUT /ort/exams/1.json
  def update
    @exam = Ort::Exam.find(params[:id])

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

  # DELETE /ort/exams/1
  # DELETE /ort/exams/1.json
  def destroy
    @exam = Ort::Exam.find(params[:id])
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to ort_exams_url }
      format.json { head :no_content }
    end
  end
end
