class LevelsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @levels = Level.of_branch(current_user.branch_id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @levels }
    end
  end

  def show
    @level = Level.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @level }
    end
  end

  def new
    @level = Level.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @level }
    end
  end

  def edit
    @level = Level.find(params[:id])
  end

  def create
    @level = Level.new(params[:level])
    @level.branch_id = current_user.branch_id

    respond_to do |format|
      if @level.save
        format.html { redirect_to @level, notice: 'Level was successfully created.' }
        format.json { render json: @level, status: :created, location: @level }
      else
        format.html { render action: "new" }
        format.json { render json: @level.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @level = Level.find(params[:id])

    respond_to do |format|
      if @level.update_attributes(params[:level].except(:created_at, :updated_at))
        format.html { redirect_to @level, notice: 'Level was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @level.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @level = Level.find(params[:id])
    @level.destroy

    respond_to do |format|
      format.html { redirect_to levels_url }
      format.json { head :no_content }
    end
  end
end
