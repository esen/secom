class Ort::ParticipantsController < ApplicationController
  # GET /ort/participants
  # GET /ort/participants.json
  def index
    if params[:q].nil?
      @participants = Ort::Participant.all
    else
      @participants = Ort::Participant.where("name LIKE '%#{params[:q]}%'")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participants.collect { |p| p.name } }
    end
  end

  # GET /ort/participants/1
  # GET /ort/participants/1.json
  def show
    @participant = Ort::Participant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /ort/participants/new
  # GET /ort/participants/new.json
  def new
    @participant = Ort::Participant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /ort/participants/1/edit
  def edit
    @participant = Ort::Participant.find(params[:id])
  end

  # POST /ort/participants
  # POST /ort/participants.json
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

  # PUT /ort/participants/1
  # PUT /ort/participants/1.json
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

  # DELETE /ort/participants/1
  # DELETE /ort/participants/1.json
  def destroy
    @participant = Ort::Participant.find(params[:id])
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to ort_participants_url }
      format.json { head :no_content }
    end
  end
end
