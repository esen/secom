class CourseTimesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @course_times = CourseTime.of_branch(current_user.branch_id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_times }
    end
  end

  def show
    @course_time = CourseTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_time }
    end
  end

  def new
    @course_time = CourseTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_time }
    end
  end

  def edit
    @course_time = CourseTime.find(params[:id])
  end

  def create
    @course_time = CourseTime.new(params[:course_time])
    @course_time.branch_id = current_user.branch_id

    respond_to do |format|
      if @course_time.save
        format.html { redirect_to @course_time, notice: 'Course time was successfully created.' }
        format.json { render json: @course_time, status: :created, location: @course_time }
      else
        format.html { render action: "new" }
        format.json { render json: @course_time.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    @course_time = CourseTime.find(params[:id])

    respond_to do |format|
      if @course_time.update_attributes(params[:course_time].except(:created_at, :updated_at))
        format.html { redirect_to @course_time, notice: 'Course time was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_time.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course_time = CourseTime.find(params[:id])
    @course_time.destroy

    respond_to do |format|
      format.html { redirect_to course_times_url }
      format.json { head :no_content }
    end
  end
end
