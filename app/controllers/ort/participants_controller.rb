class Ort::ParticipantsController < ApplicationController
  # GET /ort/participants
  # GET /ort/participants.json
  def index
    @ort_participants = Ort::Participant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ort_participants }
    end
  end

  # GET /ort/participants/1
  # GET /ort/participants/1.json
  def show
    @ort_participant = Ort::Participant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ort_participant }
    end
  end

  # GET /ort/participants/new
  # GET /ort/participants/new.json
  def new
    @ort_participant = Ort::Participant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ort_participant }
    end
  end

  # GET /ort/participants/1/edit
  def edit
    @ort_participant = Ort::Participant.find(params[:id])
  end

  # POST /ort/participants
  # POST /ort/participants.json
  def create
    @ort_participant = Ort::Participant.new(params[:ort_participant])

    respond_to do |format|
      if @ort_participant.save
        format.html { redirect_to @ort_participant, notice: 'Participant was successfully created.' }
        format.json { render json: @ort_participant, status: :created, location: @ort_participant }
      else
        format.html { render action: "new" }
        format.json { render json: @ort_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ort/participants/1
  # PUT /ort/participants/1.json
  def update
    @ort_participant = Ort::Participant.find(params[:id])

    respond_to do |format|
      if @ort_participant.update_attributes(params[:ort_participant])
        format.html { redirect_to @ort_participant, notice: 'Participant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ort_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ort/participants/1
  # DELETE /ort/participants/1.json
  def destroy
    @ort_participant = Ort::Participant.find(params[:id])
    @ort_participant.destroy

    respond_to do |format|
      format.html { redirect_to ort_participants_url }
      format.json { head :no_content }
    end
  end
end
