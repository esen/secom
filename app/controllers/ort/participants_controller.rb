class Ort::ParticipantsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show_mark]
  before_filter :authenticate_participant!, :only => [:show_mark]
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html {
        @participants = Ort::Participant.of_branch(current_user.branch_id).order(:name)
      }

      format.json {
        @participants = Ort::Participant.of_branch(current_user.branch_id).where("name LIKE ?", "%#{params[:q]}%").order(:name)
        render json: @participants.collect { |p| p.name }
      }
    end
  end

  def show
    @participant = Ort::Participant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participant }
    end
  end

  def new
    @participant = Ort::Participant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant }
    end
  end

  def edit
    @participant = Ort::Participant.find(params[:id])
  end

  def create
    @participant = Ort::Participant.new(params[:ort_participant])
    @participant.branch_id = current_user.branch_id

    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render json: @participant, status: :created, location: @participant }
      else
        format.html { render action: "new" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @participant = Ort::Participant.find(params[:id])

    respond_to do |format|
      if @participant.update_attributes(params[:ort_participant])
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @participant = Ort::Participant.find(params[:id])
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to ort_participants_url }
      format.json { head :no_content }
    end
  end

  def exams
    @participant = Ort::Participant.find(params[:id])
    @cheques = @participant.cheques
  end

  def password
    @participant = Ort::Participant.find(params[:id])

    if request.post?
      @participant.password = params[:password]
      @participant.password_confirmation = params[:password_confirmation]

      if @participant.valid?
        if @participant.save
          flash[:notice] = "Successfully changed password"
        else
          flash[:error] = "Could not change password"
        end
      else
        flash[:error] = @participant.errors.full_messages.join(". ")
      end
    end
  end

  def show_mark
    cheque_id = params[:login].to_i
    @cheque = Ort::Cheque.find(cheque_id) if cheque_id > 0
    @cheques = Ort::Cheque.where(:participant_id => current_participant.id).order("created_at DESC")
  end
end
