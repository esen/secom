class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html do
        @payments = Payment.of_branch(current_user.branch_id).all
        @sources = Source.of_branch(current_user.branch_id).all
      end

      format.json do
        @payments = (params[:student_id]) ?
            Payment.of_branch(current_user.branch_id).of_student(params[:student_id]).order("payments.updated_at DESC") :
            Payment.of_branch(current_user.branch_id).order("updated_at DESC")

        render json: @payments
      end
    end
  end

  def show
    @payment = Payment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  def new
    @payment = Payment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment }
    end
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def create
    @payment = Payment.new(params[:payment].except(:created_at, :updated_at, :ort_participant_id))
    @payment.branch_id = current_user.branch_id

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render json: @payment, status: :created, location: @payment }
      else
        format.html { render action: "new" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:payment].except(:created_at, :updated_at, :ort_participant_id))
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end
end
