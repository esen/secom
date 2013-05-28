# encoding: utf-8

class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @groups = with_courses(
        Group.of_branch(current_user.branch_id).
            joins("LEFT JOIN students ON groups.id = students.group_id").
            group("groups.id").
            select("groups.*, COUNT(students.id) AS student_num")
    )
    @levels = Level.of_branch(current_user.branch_id).all
    @student = Student.find(params[:student_id]) if params[:student_id]

    if current_user.role == 'vd'
      @lessons = Lesson.of_branch(current_user.branch_id).all
      @course_times = CourseTime.of_branch(current_user.branch_id).all
      @teachers = Teacher.of_branch(current_user.branch_id).all
      @rooms = Room.of_branch(current_user.branch_id).all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  def show
    @group = with_courses([Group.find(params[:id])]).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(params[:group].except(:created_at, :updated_at, :to_pay, :capacity, :course_names, :student_num))
    @group.branch_id = current_user.branch_id

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group].except(:created_at, :updated_at, :to_pay, :capacity, :course_names, :student_num))
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json do
        begin
          @group.destroy
          render json: {status: "success"}
        rescue
          render json: {status: "error", error: 'Бул группаны өчүрүүгө болбойт'}
        end
      end
    end
  end

  def activate
    @group = Group.find(params[:id])

    respond_to do |format|
      format.json do
        @group.active = true
        if @group.valid?
          if @group.save
            render json: {status: "success", group: @group}
          else
            render json: {status: "error", error: @group.errors.full_messages}
          end
        else
          @group.active = false
          if params_valid
            @group.payment_dates.destroy_all
            @group.started_at = Date.parse(params[:started_at])

            price = @group.price
            sum = params[:period]=="month" ? params[:monthsum].to_i : params[:dayssum].to_i

            if params[:period]=="month"
              date = @group.started_at
              month_day = params[:monthday].to_i

              if month_day > 0
                date = (date.mday <= month_day) ?
                    Date.new(date.year, date.month, month_day) :
                    Date.new(date.year, date.month, month_day) + 1.months
              end

              while price > 0
                sum = (price > sum) ? sum : price
                @group.payment_dates.new :amount => sum, :payment_date => date, :branch_id => current_user.branch_id
                price -= sum
                date = date + 1.months
              end
            else
              date = @group.started_at
              month_day = params[:daysday].to_i

              while price > 0
                sum = (price > sum) ? sum : price
                @group.payment_dates.new :amount => sum, :payment_date => date, :branch_id => current_user.branch_id
                price -= sum
                date = date + month_day.days
              end
            end

            if @group.save
              render json: {status: "success", group: @group, payment_dates: @group.payment_dates}
            else
              render json: {status: "error", error: @group.errors.full_messages}
            end
          else
            render json: {status: "error", error: "Параметрлер туура эмес берилди!"}
          end
        end
      end
    end
  end

  def deactivate
    @group = Group.find(params[:id])

    respond_to do |format|
      format.json do
        @group.active = false
        if @group.save
          render json: {status: "success", group: @group}
        else
          render json: {status: "error", error: @group.errors.full_messages}
        end
      end
    end
  end

  private

  def params_valid
    valid = true
    valid = false unless (Date.parse(params[:started_at]) rescue false)
    valid = false unless ["month", "days"].include? params[:period]

    if valid && @group.price > 0
      if params[:period] == "month"
        valid = false unless params[:monthday].to_i > 0 && params[:monthday].to_i < 31
        valid = false unless params[:monthsum].to_i > 0 && params[:monthsum].to_i < @group.price
      else
        valid = false unless params[:daysday].to_i > 0 && params[:daysday].to_i < 1000
        valid = false unless params[:dayssum].to_i > 0 && params[:dayssum].to_i < @group.price
      end
    end

    valid
  end

  def with_courses(groups)
    courses = {}
    Course.of_branch(current_user.branch_id).joins(:lesson).select("courses.group_id, lessons.title").each do |c|
      courses[c.group_id] = [] unless courses[c.group_id]
      courses[c.group_id] << c.title
    end

    gs = []
    groups.each do |g|
      gs << g.attributes.merge(course_names: courses[g.id])
    end

    gs
  end
end
