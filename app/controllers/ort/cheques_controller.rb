class Ort::ChequesController < ApplicationController
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
    @cheque = Ort::Cheque.new
    @cheque.participant = Ort::Participant.find_or_create_by_name(params[:ort_cheque][:participant])

    exam_type = Ort::ExamType.find_by_name(params[:exam_name])
    exams = Ort::Exam.where(:exam_type_id => exam_type.id, :start_date => params[:exam_date])

    if exams.count == 1
      @cheque.exam = exams.first

      if @cheque.save
        if params[:payment_amount]
          unless @cheque.exam.payments.create(:participant => @cheque.participant, :amount => params[:payment_amount])
            flash[:error] = "Payment could not be created!!!"
          end
        end

        redirect_to @cheque, notice: 'Cheque was successfully created. '
        return
      end
    else
      flash[:error] = "Please select only one of exams!!!"
    end

    @cheque.participant = nil
    flash[:error] = "Could not be saved"
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
    @cheque.destroy

    respond_to do |format|
      format.html { redirect_to ort_cheques_url }
      format.json { head :no_content }
    end
  end
end
