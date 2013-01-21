class Ort::ChequesController < ApplicationController
  # GET /ort/cheques
  # GET /ort/cheques.json
  def index
    @cheques = Ort::Cheque.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cheques }
    end
  end

  # GET /ort/cheques/1
  # GET /ort/cheques/1.json
  def show
    @cheque = Ort::Cheque.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cheque }
    end
  end

  # GET /ort/cheques/new
  # GET /ort/cheques/new.json
  def new
    @cheque = Ort::Cheque.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cheque }
    end
  end

  # GET /ort/cheques/1/edit
  def edit
    @cheque = Ort::Cheque.find(params[:id])
  end

  # POST /ort/cheques
  # POST /ort/cheques.json
  def create
    @cheque = Ort::Cheque.new(params[:ort_cheque])

    respond_to do |format|
      if @cheque.save
        format.html { redirect_to @cheque, notice: 'Cheque was successfully created.' }
        format.json { render json: @cheque, status: :created, location: @cheque }
      else
        format.html { render action: "new" }
        format.json { render json: @cheque.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ort/cheques/1
  # PUT /ort/cheques/1.json
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

  # DELETE /ort/cheques/1
  # DELETE /ort/cheques/1.json
  def destroy
    @cheque = Ort::Cheque.find(params[:id])
    @cheque.destroy

    respond_to do |format|
      format.html { redirect_to ort_cheques_url }
      format.json { head :no_content }
    end
  end
end
