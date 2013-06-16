class TestsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :filter_params
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html do
        if current_user.role = 'tr'
          teacher = current_user.teacher

          @course = Course.find(params[:course_id]) if params[:course_id]
          @courses = teacher.courses.joins(:lesson).joins(:group).
              select("courses.*, lessons.title AS lesson_name, groups.name AS group_name")

          if @course
            @tests = Test.joins(:course).
                joins("LEFT JOIN lessons ON courses.lesson_id = lessons.id").
                joins("LEFT JOIN groups ON courses.group_id = groups.id").
                where("courses.teacher_id = ? AND homework = ? AND course_id = ?", teacher.id, params[:homework] == 'true', @course.id).
                order("courses.group_id").
                select("tests.*, lessons.title AS course_name, groups.name AS group_name")
          else
            @tests = Test.joins(:course).
                joins("LEFT JOIN lessons ON courses.lesson_id = lessons.id").
                joins("LEFT JOIN groups ON courses.group_id = groups.id").
                where("courses.teacher_id = ? AND homework = ?", teacher.id, params[:homework] == 'true').
                order("courses.group_id").
                select("tests.*, lessons.title AS course_name, groups.name AS group_name")
          end
        end
      end

      format.json do
        @tests = (params[:course_id]) ? Test.of_course(params[:course_id]) : []

        render json: @tests
      end
    end
  end

  def marks
    respond_to do |format|
      format.json do
        status = :success

        marks = params[:marks].split("|")
        test = Test.find(params[:test_id])
        test_results = TestResult.of_test(test.id)
        existing_results = test_results.inject({}) { |h, tr| h[tr.student_id] = tr; h }

        marks.each do |m|
          id, mark = m.split("=")
          mark = mark.to_i
          id = id.to_i

          if existing_results[id].nil?
            test.test_results.new :student_id => id, :mark => mark
          elsif existing_results[id].mark != mark
            existing_results[id].mark = mark
            existing_results[id].save
          end
        end

        begin
          test.save
        rescue Exception => e
          status = :error
        end

        test_results.reload
        results = test_results.inject({}) { |h, tr| h[tr.student_id] = tr.mark; h }

        render json: {:status => status, :results => results}
      end
    end
  end

  def show
    @test = Test.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test }
    end
  end

  def new
    @test = Test.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test }
    end
  end

  def edit
    @test = Test.find(params[:id])
  end

  def create
    @test = Test.new(params[:test])

    respond_to do |format|
      if @test.save
        format.html { redirect_to @test, notice: 'Test was successfully created.' }
        format.json { render json: @test, status: :created, location: @test }
      else
        format.html { render action: "new" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @test = Test.find(params[:id])

    respond_to do |format|
      if @test.update_attributes(params[:test])
        format.html { redirect_to @test, notice: 'Test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @test = Test.find(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to tests_url }
      format.json { head :no_content }
    end
  end

  private

  def filter_params
    params[:test] = params[:test].except(:created_at, :updated_at, :group_name, :course_name) if params[:test]
  end
end
