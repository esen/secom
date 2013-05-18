class StudentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.html do
        @students = Student.of_branch(current_user.branch_id).all
        @groups = Group.of_branch(current_user.branch_id).all
      end

      format.json do
        if params[:group_id]
          @group = Group.of_branch(current_user.branch_id).
              joins(:payment_dates).
              where("groups.id = ? AND payment_dates.payment_date <= ?", params[:group_id], Date.today).
              group(:id).
              select("groups.*, SUM(payment_dates.amount) AS to_pay").first

          @payment_dates = Group.find(params[:group_id]).payment_dates

          @students = Student.of_branch(current_user.branch_id).
              of_group(params[:group_id]).
              joins("LEFT JOIN payments ON payments.student_id=students.id").
              group(:id).
              select("students.*, SUM(payments.amount) AS total_payment")

          render json: {group: @group, students: @students, payment_dates: @payment_dates}
        else
          @students = Student.of_branch(current_user.branch_id).all
          render json: @students
        end
      end
    end
  end

  def show
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end

  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(params[:student])
    @student.branch_id = current_user.branch_id

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render json: @student, status: :created, location: @student }
      else
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student].except(:created_at, :updated_at, :total_payment))
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  def activate
    @student = Student.find(params[:id])

    respond_to do |format|
      format.json do
        @student.active = true
        if @student.save
          render json: {status: "success", student: @student}
        else
          render json: {status: "error", error: @student.errors.full_messages}
        end
      end
    end
  end

  def deactivate
    @student = Student.find(params[:id])

    respond_to do |format|
      format.json do
        @student.active = false
        if @student.save
          render json: {status: "success", student: @student}
        else
          render json: {status: "error", error: @student.errors.full_messages}
        end
      end
    end
  end
end
