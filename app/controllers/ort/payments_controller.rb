class Ort::PaymentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :find_participant, :find_exam, :find_cheque

  def index
    @payments = Ort::Payment.of_branch(current_user.branch_id).
        joins(:exam).
        joins(:participant).
        joins("LEFT JOIN ort_exam_types AS oets ON oets.id = ort_exams.exam_type_id")

    @payments = @payments.where(:participant_id => @participant.id) if @participant
    @payments = @payments.where(:exam_id => @exam.id) if @exam
    @payments = @payments.where(:exam_id => @cheque.exam_id, :participant_id => @cheque.participant_id) if @cheque
    @payments = @payments.select("ort_payments.*, oets.name AS exam_name, ort_exams.start_date AS exam_date, ort_participants.name AS participant_name")

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
    @payment.branch_id = current_user.branch_id
    msg << "Participant not found" if @payment.participant.nil?

    exam_type = Ort::ExamType.find_by_name(params[:exam_name])
    exams = Ort::Exam.where(:exam_type_id => exam_type.id, :start_date => params[:exam_date])

    if exams.count == 1
      @payment.exam = exams.first
      @payment.amount = params[:amount]

      if @payment.participant && !@payment.participant.is_enrolled_to(@payment.exam)
        msg << "The participant is not enrolled yet"
        @enroll_link = true
      elsif @payment.save
        redirect_to get_path(:show), notice: 'Payment was successfully created. '
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

    if @payment.update_attributes(params[:ort_payment])
      redirect_to get_path(:show), notice: 'Payment was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @payment = Ort::Payment.find(params[:id])
    @payment.destroy

    redirect_to get_path(:index)
  end

  private

  def get_path(method)
    if @participant
      method == :show ? ort_participant_payment_url(@participant, @payment) : ort_participant_payments_url(@participant)
    elsif @exam
      method == :show ? ort_exam_payment_url(@exam, @payment) : ort_exam_payments_url(@exam)
    elsif @cheque
      method == :show ? ort_cheque_payment_url(@cheque, @payment) : ort_cheque_payments_url(@cheque)
    else
      method == :show ? ort_payment_url(@payment) : ort_payments_url
    end
  end

  def find_participant
    @participant = Ort::Participant.find(params[:participant_id]) if params[:participant_id]
  end

  def find_exam
    @exam = Ort::Exam.find(params[:exam_id]) if params[:exam_id]
  end

  def find_cheque
    @cheque = Ort::Cheque.find(params[:cheque_id]) if params[:cheque_id]
  end
end
