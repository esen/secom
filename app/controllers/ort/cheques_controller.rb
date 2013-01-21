class Ort::ChequesController < ApplicationController
  # GET /ort/cheques
  # GET /ort/cheques.json
  def index
    @ort_cheques = Ort::Cheque.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ort_cheques }
    end
  end

  # GET /ort/cheques/1
  # GET /ort/cheques/1.json
  def show
    @ort_cheque = Ort::Cheque.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ort_cheque }
    end
  end

  # GET /ort/cheques/new
  # GET /ort/cheques/new.json
  def new
    @ort_cheque = Ort::Cheque.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ort_cheque }
    end
  end

  # GET /ort/cheques/1/edit
  def edit
    @ort_cheque = Ort::Cheque.find(params[:id])
  end

  # POST /ort/cheques
  # POST /ort/cheques.json
  def create
    @ort_cheque = Ort::Cheque.new(params[:ort_cheque])

    respond_to do |format|
      if @ort_cheque.save
        format.html { redirect_to @ort_cheque, notice: 'Cheque was successfully created.' }
        format.json { render json: @ort_cheque, status: :created, location: @ort_cheque }
      else
        format.html { render action: "new" }
        format.json { render json: @ort_cheque.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ort/cheques/1
  # PUT /ort/cheques/1.json
  def update
    @ort_cheque = Ort::Cheque.find(params[:id])

    respond_to do |format|
      if @ort_cheque.update_attributes(params[:ort_cheque])
        format.html { redirect_to @ort_cheque, notice: 'Cheque was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ort_cheque.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ort/cheques/1
  # DELETE /ort/cheques/1.json
  def destroy
    @ort_cheque = Ort::Cheque.find(params[:id])
    @ort_cheque.destroy

    respond_to do |format|
      format.html { redirect_to ort_cheques_url }
      format.json { head :no_content }
    end
  end
end
