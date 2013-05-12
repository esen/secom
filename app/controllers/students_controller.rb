class StudentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.html do
        @students = Student.all
        @groups = Group.all
      end

      format.json do
        if params[:group_id]
          @group = Group.
              joins(:payment_dates).
              where("groups.id = ? AND payment_dates.payment_date <= ?", params[:group_id], Date.today).
              group(:id).
              select("groups.*, SUM(payment_dates.amount) AS to_pay").first

          @students = Student.
              of_group(params[:group_id]).
              joins("LEFT JOIN payments ON payments.student_id=students.id").
              group(:id).
              select("students.*, SUM(payments.amount) AS total_payment")

          render json: {group: @group, students: @students}
        else
          @students = Student.all
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
      if @student.update_attributes(params[:student].except(:created_at, :updated_at))
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
end
