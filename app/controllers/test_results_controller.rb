class TestResultsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :filter_params
  load_and_authorize_resource

  def index
    test = Test.find(params[:test_id])
    @test_results = TestResult.of_test(test.id)
    @students = test.course.group.students

    @results = {}
    @test_results.each do |tr|
      @results[tr.student_id] = tr.mark
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {"results" => @results, "students" => @students} }
    end
  end

  def show
    @test_result = TestResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test_result }
    end
  end

  def new
    @test_result = TestResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test_result }
    end
  end

  def edit
    @test_result = TestResult.find(params[:id])
  end

  def create
    @test_result = TestResult.new(params[:test_result])

    respond_to do |format|
      if @test_result.save
        format.html { redirect_to @test_result, notice: 'Test result was successfully created.' }
        format.json { render json: @test_result, status: :created, location: @test_result }
      else
        format.html { render action: "new" }
        format.json { render json: @test_result.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @test_result = TestResult.find(params[:id])

    respond_to do |format|
      if @test_result.update_attributes(params[:test_result])
        format.html { redirect_to @test_result, notice: 'Test result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test_result.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @test_result = TestResult.find(params[:id])
    @test_result.destroy

    respond_to do |format|
      format.html { redirect_to test_results_url }
      format.json { head :no_content }
    end
  end

  private

  def filter_params
    params[:test_result] = params[:test_result].except(:student_name) if params[:test_result]
  end
end
