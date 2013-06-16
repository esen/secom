class TeachersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :filter_params
  load_and_authorize_resource

  def index
    @teachers = Teacher.of_branch(current_user.branch_id).all
    @lessons = Lesson.of_branch(current_user.branch_id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teachers }
    end
  end

  def show
    @teacher = Teacher.joins(:user).select("teacher.*, user.username, user.email").where(:id => params[:id]).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @teacher }
    end
  end

  def new
    @teacher = Teacher.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @teacher }
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def create
    respond_to do |format|
      format.json do
        @teacher = Teacher.new(params[:teacher])
        @teacher.branch_id = current_user.branch_id

        errors = nil
        if @teacher.valid?
          user_params = {
              name: @teacher.name + " " + @teacher.surname,
              role: "tr",
              username: @new_user[:username],
              email: @new_user[:email],
              password: @new_user[:password],
              password_confirmation: @new_user[:password],
              branch_id: current_user.branch_id
          }

          @user = User.new user_params
          if @user.save
            @teacher.user_id = @user.id
            unless @teacher.save
              errors = @teacher.errors.full_messages
              @user.destroy
            end
          else
            errors = @user.errors.full_messages
          end
        else
          errors = @teacher.errors.full_messages
        end

        if errors.nil?
          render json: @teacher, status: :created, location: @teacher
        else
          render json: errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        @teacher = Teacher.find(params[:id])

        if @teacher.update_attributes(params[:teacher].except(:created_at, :updated_at))
          @user = @teacher.user

          if @new_user[:password].length > 0
            @user.password = @new_user[:password]
            @user.password_confirmation = @new_user[:password]
            if @user.save
              head :no_content
            else
              render json: @user.errors, status: :unprocessable_entity
            end
          end
        else
          render json: @teacher.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to teachers_url }
      format.json { head :no_content }
    end
  end

  private

  def filter_params
    if params[:teacher]
      @new_user = {}
      @new_user[:username] = params[:teacher][:username]
      @new_user[:email] = params[:teacher][:email]
      @new_user[:password] = params[:teacher][:password]

      params[:teacher] = params[:teacher].except(:created_at, :updated_at, :username, :email, :password, :password_confirmation, :user_id, :id)
    end
  end
end
