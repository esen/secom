class AttendancesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json do
        if params[:course_id]
          attendances = Attendance.of_course(params[:course_id])

          #course = Course.find(params[:course_id])
          #course_dates = course.dates
          #if course_dates.count == 0
          #  group = Group.find(course.group_id)
          #  last_date = group.started_at
          #else
          #  last_date = course_dates.last + 1.days
          #end
          #
          #today = Date.today
          #weekdays = []
          #weekdays << 1 if course.monday?
          #weekdays << 2 if course.tuesday?
          #weekdays << 3 if course.wednesday?
          #weekdays << 4 if course.thursday?
          #weekdays << 5 if course.friday?
          #weekdays << 6 if course.saturday?
          #weekdays << 7 if course.sunday?
          #
          #while last_date <= today
          #  course_dates << last_date if weekdays.include? last_date.wday
          #  last_date += 1.days
          #  break if course_dates.count > 1000
          #end

          render json: {:attendances => attendances, :course_dates => course_dates}
        else
          render json: {}
        end
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
