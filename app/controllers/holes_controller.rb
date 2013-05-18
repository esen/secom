class HolesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @holes = Hole.of_branch(current_user.branch_id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @holes }
    end
  end

  def show
    @hole = Hole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hole }
    end
  end

  def new
    @hole = Hole.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hole }
    end
  end

  def edit
    @hole = Hole.find(params[:id])
  end

  def create
    @hole = Hole.new(params[:hole])
    @hole.branch_id = current_user.branch_id

    respond_to do |format|
      if @hole.save
        format.html { redirect_to @hole, notice: 'Hole was successfully created.' }
        format.json { render json: @hole, status: :created, location: @hole }
      else
        format.html { render action: "new" }
        format.json { render json: @hole.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @hole = Hole.find(params[:id])

    respond_to do |format|
      if @hole.update_attributes(params[:hole].except(:created_at, :updated_at))
        format.html { redirect_to @hole, notice: 'Hole was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hole.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hole = Hole.find(params[:id])
    @hole.destroy

    respond_to do |format|
      format.html { redirect_to holes_url }
      format.json { head :no_content }
    end
  end
end
