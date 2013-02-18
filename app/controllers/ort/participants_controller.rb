class Ort::ParticipantsController < ApplicationController
  before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.html {
        @participants = Ort::Participant.all
      }

      format.json {
        @participants = Ort::Participant.where("name LIKE ?", "%#{params[:q]}%")
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
end
