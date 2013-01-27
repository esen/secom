class Ort::PaymentsController < ApplicationController
  def index
    @payments = Ort::Payment.
        joins(:exam).
        joins(:participant).
        joins("LEFT JOIN ort_exam_types AS oets ON oets.id = ort_exams.exam_type_id").
        select("ort_payments.*, oets.name AS exam_name, ort_exams.start_date AS exam_date, ort_participants.name AS participant_name")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  def show
    @payment = Ort::Payment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  def new
    @payment = Ort::Payment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment }
    end
  end

  def edit
    @payment = Ort::Payment.find(params[:id])
  end

  def create
    msg = []
    @payment = Ort::Payment.new
    @payment.participant = Ort::Participant.find_by_name(params[:participant])
    msg << "Participant not found" if @payment.participant.nil?

    exam_type = Ort::ExamType.find_by_name(params[:exam_name])
    exams = Ort::Exam.where(:exam_type_id => exam_type.id, :start_date => params[:exam_date])

    if exams.count == 1
      @payment.exam = exams.first
      @payment.amount = params[:amount]

      if !@payment.participant.is_enrolled_to(@payment.exam)
        msg << "The participant is not enrolled yet"
        @enroll_link = true
      elsif @payment.save
        redirect_to @payment, notice: 'Payment was successfully created. '
        return
      else
        msg << "Could not be saved"
      end
    else
      msg << "Could not find exam"
    end

    flash[:error] = msg.join(". ")
    render action: "new"
  end

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

  def destroy
    @payment = Ort::Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to ort_payments_url }
      format.json { head :no_content }
    end
  end
end
