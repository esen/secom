class PaymentDatesController < ApplicationController
  before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.html do
        @payment_dates = PaymentDate.of_branch(current_user.branch_id).all
        @groups = Group.of_branch(current_user.branch_id).all
      end

      format.json do
        @payment_dates = (params[:group_id]) ?
            PaymentDate.of_group(params[:group_id]).order(:payment_date) :
            PaymentDate.order(:payment_date)

        render json: @payment_dates
      end
    end
  end

  def show
    @payment_date = PaymentDate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment_date }
    end
  end

  def new
    @payment_date = PaymentDate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment_date }
    end
  end

  def edit
    @payment_date = PaymentDate.find(params[:id])
  end

  def create
    @payment_date = PaymentDate.new(params[:payment_date])
    @payment_date.branch_id = current_user.branch_id

    respond_to do |format|
      if @payment_date.valid? && @payment_date.save
        format.html { redirect_to @payment_date, notice: 'Payment date was successfully created.' }
        format.json { render json: @payment_date, status: :created, location: @payment_date }
      else
        format.html { render action: "new" }
        format.json { render json: @payment_date.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    @payment_date = PaymentDate.find(params[:id])

    respond_to do |format|
      if @payment_date.update_attributes(params[:payment_date].except(:created_at, :updated_at))
        format.html { redirect_to @payment_date, notice: 'Payment date was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment_date.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment_date = PaymentDate.find(params[:id])
    @payment_date.destroy

    respond_to do |format|
      format.html { redirect_to payment_dates_url }
      format.json { head :no_content }
    end
  end
end
