class Ort::PaymentsController < ApplicationController
  # GET /ort/payments
  # GET /ort/payments.json
  def index
    @payments = Ort::Payment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  # GET /ort/payments/1
  # GET /ort/payments/1.json
  def show
    @payment = Ort::Payment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /ort/payments/new
  # GET /ort/payments/new.json
  def new
    @payment = Ort::Payment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /ort/payments/1/edit
  def edit
    @payment = Ort::Payment.find(params[:id])
  end

  # POST /ort/payments
  # POST /ort/payments.json
  def create
    @payment = Ort::Payment.new(params[:ort_payment])

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

  # PUT /ort/payments/1
  # PUT /ort/payments/1.json
  def update
    @payment = Ort::Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:ort_payment])
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ort/payments/1
  # DELETE /ort/payments/1.json
  def destroy
    @payment = Ort::Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to ort_payments_url }
      format.json { head :no_content }
    end
  end
end
