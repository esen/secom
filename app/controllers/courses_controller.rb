class CoursesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :filter_params
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html do
        if current_user.role = 'tr'
          @courses = current_user.teacher.courses.
              joins(:group).joins(:lesson).joins(:room).joins(:course_time).
              select("courses.*, groups.name AS group_name, lessons.title AS lesson_name, rooms.title AS room_name, " +
                         "CONCAT(course_times.starts_at, ' - ', course_times.ends_at) AS course_times")
        end
      end

      format.json do
        @courses = (params[:group_id]) ? Course.of_group(params[:group_id]) : []

        render json: @courses
      end
    end
  end

  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(params[:course].except(:created_at, :updated_at, :group_name, :lesson_name, :room_name, :course_times))
    @course.branch_id = current_user.branch_id

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course].except(:created_at, :updated_at, :group_name, :lesson_name, :room_name, :course_times))
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def filter_params
    params[:course] = params[:course].except(:created_at, :updated_at, :group_name, :lesson_name, :room_name, :course_times) if params[:course]
  end
end
