class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @groups = Group.all
    @levels = Level.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json do
        if params[:period]
          if params_valid
            @group.payment_dates.destroy_all
            @group.started_at = Date.parse(params[:started_at])

            price = @group.price
            sum = params[:period]=="month" ? params[:monthsum].to_i : params[:dayssum].to_i

            if params[:period]=="month"
              date = @group.started_at
              month_day = params[:monthday].to_i

              date = (date.mday <= month_day) ?
                  Date.new(date.year, date.month, month_day) :
                  Date.new(date.year, date.month, month_day) + 1.months

              while price > 0
                sum = (price > sum) ? sum : price
                @group.payment_dates.new :amount => sum, :payment_date => date
                price -= sum
                date = date + 1.months
              end
            else
              date = @group.started_at
              month_day = params[:daysday].to_i

              while price > 0
                sum = (price > sum) ? sum : price
                @group.payment_dates.new :amount => sum, :payment_date => date
                price -= sum
                date = date + month_day.days
              end
            end

            if @group.save
              render json: @group.payment_dates
            else
              render json: {error: true}, status: :unprocessable_entity
            end
          else
            render json: {error: true}, status: :unprocessable_entity
          end
        else
          render json: @group
        end
      end
    end
  end

  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group].except(:created_at, :updated_at))
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  private

  def params_valid
    valid = true
    valid = false unless (Date.parse(params[:started_at]) rescue false)
    valid = false unless ["month", "days"].include? params[:period]

    if valid
      if params[:period] == "month"
        valid = false unless params[:monthday].to_i > 0 && params[:monthday].to_i < 31
        valid = false unless params[:monthsum].to_i > 0 && params[:monthsum].to_i < @group.price
      else
        valid = false unless params[:daysday].to_i > 0 && params[:daysday].to_i < 1000
        valid = false unless params[:dayssum].to_i > 0 && params[:dayssum].to_i < @group.price
      end
    end

    valid
  end
end
