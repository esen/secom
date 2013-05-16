class ExpensesController < ApplicationController
  before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.html do
        @expenses = Expense.all
        @holes = Hole.all
      end

      format.json do
        @expenses = (params[:teacher_id]) ?
            Expense.of_teacher(params[:teacher_id]).order("expenses.updated_at DESC") :
            Expense.order("updated_at DESC")

        render json: @expenses
      end
    end
  end

  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  def new
    @expense = Expense.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def create
    @expense = Expense.new(params[:expense])

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense].except(:created_at, :updated_at))
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
    end
  end
end
