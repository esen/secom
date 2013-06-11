class AttendancesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json do
        if params[:course_id]
          attendances = Attendance.of_course(params[:course_id]).order("checked_at DESC")
          attendances = attendances.limit(20) unless params[:all] == 'true'
          course = Course.find(params[:course_id])
          students = Student.of_group(course.group_id).select([:id, :name, :surname])


          render json: {:attendances => attendances, :students => students}
        else
          render json: {}
        end
      end
    end
  end

  def check
    course = Course.find(params[:course_id])
    date = Date.parse(params[:date])
    student_ids = params[:students].split('|')

    status = :success
    attendances = Attendance.of_course(course.id).where(:checked_at => date, :attended => true)

    grouped_by_student = {}
    attendances.each do |a|
      grouped_by_student[a.student_id] = a
    end

    student_ids.each do |id|
      unless grouped_by_student[id]
        course.attendances.new :checked_at => date, :student_id => id, :attended => true
      end
    end

    begin
      course.save!
    rescue Exception => e
      status = :error
    end

    grouped_by_student.each_pair do |id, a|
      unless student_ids.include? id
        begin
          a.destroy
        rescue Exception => e
          status = :error
        end
      end
    end

    respond_to do |format|
      format.json do
        render json: {:status => status}
      end
    end
  end

  def show
    @attendance = Attendance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attendance }
    end
  end

  def new
    @attendance = Attendance.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attendance }
    end
  end

  def edit
    @attendance = Attendance.find(params[:id])
  end

  def create
    @attendance = Attendance.new(params[:attendance].except(:checked_at))

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @attendance, notice: 'Attendance was successfully created.' }
        format.json { render json: @attendance, status: :created, location: @attendance }
      else
        format.html { render action: "new" }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @attendance = Attendance.find(params[:id])

    respond_to do |format|
      if @attendance.update_attributes(params[:attendance].except(:checked_at))
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.destroy

    respond_to do |format|
      format.html { redirect_to attendances_url }
      format.json { head :no_content }
    end
  end
end
