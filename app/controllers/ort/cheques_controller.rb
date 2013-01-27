class Ort::ChequesController < ApplicationController
  before_filter :find_participant

  def index
    @cheques = Ort::Cheque.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cheques }
    end
  end

  def show
    @cheque = Ort::Cheque.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cheque }
    end
  end

  def new
    @cheque = Ort::Cheque.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cheque }
    end
  end

  def edit
    @cheque = Ort::Cheque.find(params[:id])
  end

  def create
    msg = []
    @cheque = Ort::Cheque.new
    @cheque.participant = Ort::Participant.find_or_create_by_name(params[:participant])
    msg << "Participant not found and can't be created'" if @cheque.participant.nil?

    exam_type = Ort::ExamType.find_by_name(params[:exam_name])
    exams = Ort::Exam.where(:exam_type_id => exam_type.id, :start_date => params[:exam_date])

    if exams.count == 1
      @cheque.exam = exams.first

      if @cheque.participant.is_enrolled_to(@cheque.exam)
        msg << "This participant is already enrolled to this exam"
      elsif @cheque.save
        if params[:payment_amount]
          unless @cheque.exam.payments.create(:participant => @cheque.participant, :amount => params[:payment_amount])
            msg << "Payment could not be created!!!"
          end
        end

        redirect_to @cheque, notice: 'Cheque was successfully created. '
        return
      else        payments.where(:exam_id => @cheque.exam_id)
        msg << "Could not be saved"
      end
    else
      msg << "Could not find exam"
    end

    flash[:error] = msg.join(". ")
    render action: "new"
  end

  def update
    @cheque = Ort::Cheque.find(params[:id])

    respond_to do |format|
      if @cheque.update_attributes(params[:ort_cheque])
        format.html { redirect_to @cheque, notice: 'Cheque was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cheque.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cheque = Ort::Cheque.find(params[:id])
    unless @cheque.participant.has_payment_for(@cheque.exam)
      @cheque.destroy
    else
      flash[:error] = "You can't delete this cheque, because the participant has paid #{@cheque.participant.paid_for(@cheque.exam)} soms for this exam."
    end

    path = @participant.nil? ? ort_participants_url : exams_ort_participant_url(@participant)
    redirect_to path
  end

  private

  def find_participant
    @participant = Ort::Participant.find(params[:participant_id]) if params[:participant_id]
  end
end
