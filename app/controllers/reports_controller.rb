class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def main
    case current_user.role
      when 'gd' then
        @branches = {}
        Branch.all.collect { |b| @branches[b.id] = b.name }
        @data = {
            students_nums: Student.not_finished.group(:branch_id).select("branch_id, COUNT(*) AS student_num"),
            groups_nums: Group.not_finished.group(:branch_id).select("branch_id, COUNT(*) AS group_num"),
            teachers_nums: Teacher.group(:branch_id).select("branch_id, COUNT(*) AS teacher_num"),
            moneys: difference(
                Payment.group(:branch_id).select("branch_id, SUM(amount) AS total_amount"),
                Ort::Payment.group(:branch_id).select("branch_id, SUM(amount) AS total_amount"),
                Expense.group(:branch_id).select("branch_id, SUM(amount) AS total_amount")
            )
        }
      when 'dr' then
        @data = {
            students_num: Student.of_branch(current_user.branch_id).not_finished.count,
            groups_num: Group.of_branch(current_user.branch_id).not_finished.count,
            teachers_num: Teacher.of_branch(current_user.branch_id).count,
            money: Payment.of_branch(current_user.branch_id).sum(:amount) +
                Ort::Payment.of_branch(current_user.branch_id).sum(:amount) -
                Expense.of_branch(current_user.branch_id).sum(:amount)
        }
      when 'vd' then
        @data = {
            students_num: Student.of_branch(current_user.branch_id).not_finished.count,
            groups_num: Group.of_branch(current_user.branch_id).not_finished.count,
            teachers_num: Teacher.of_branch(current_user.branch_id).count,
        }
      when 'ac' then
        @data = {
            students_num: Student.of_branch(current_user.branch_id).not_finished.count,
            groups_num: Group.of_branch(current_user.branch_id).not_finished.count,
            teachers_num: Teacher.of_branch(current_user.branch_id).count,
            money: Payment.of_branch(current_user.branch_id).sum(:amount) +
                Ort::Payment.of_branch(current_user.branch_id).sum(:amount) -
                Expense.of_branch(current_user.branch_id).sum(:amount)
        }
      when 'ad' then
        @data = {
            students_num: Student.of_branch(current_user.branch_id).not_finished.count,
            groups_num: Group.of_branch(current_user.branch_id).not_finished.count,
        }
      when 'tr' then
        @data = {
            students_num: Student.of_branch(current_user.branch_id).not_finished.count,
            groups_num: Group.of_branch(current_user.branch_id).not_finished.count,
        }
    end
  end

  def funds
    @expenses = {}
    @payments = {}

    case params[:period]
      when 'time_range' then
        @start_date = Date.parse(params[:start_date]) rescue Date.today - 1.months
        @end_date = Date.parse(params[:end_date]) rescue Date.today
        @start_date = @end_date if @start_date > @end_date
      when 'month' then
        @month_year = params[:month_year].to_i
        @month_year = Date.today.year if @month_year <= 2000 || @month_year > 2200
        @month_month = params[:month_month].to_i
        @month_month = Date.today.month if @month_month <= 0 || @month_month > 12

        @start_date = Date.new(@month_year, @month_month, 1)
        @end_date = @start_date + 1.months - 1.days
      else
        @start_date = Date.today - 1.months
        @end_date = Date.today
    end

    if current_user.role == 'gd'
      # expenses
      @expenses[:teachers] = Expense.joins(:teacher).
          where("expenses.expended_at BETWEEN ? AND ?", @start_date, @end_date).sum(:amount)
      @expenses[:holes] = Expense.joins(:hole).
          where("expenses.expended_at BETWEEN ? AND ?", @start_date, @end_date).sum(:amount)
      @expenses[:others] = Expense.
          where("hole_id IS NULL AND teacher_id IS NULL").
          where("expenses.expended_at BETWEEN ? AND ?", @start_date, @end_date).sum(:amount)


      # payments
      @payments[:students] = Payment.joins(:student).
          where("payments.payed_at BETWEEN ? AND ?", @start_date, @end_date).sum(:amount)
      @payments[:ort_participants] = Ort::Payment.
          where("ort_payments.created_at BETWEEN ? AND ?", @start_date, @end_date).sum(:amount)
      @payments[:sources] = Payment.joins(:source).
          where("payments.payed_at BETWEEN ? AND ?", @start_date, @end_date).sum(:amount)
      @payments[:others] = Payment.
          where("source_id IS NULL AND student_id IS NULL").
          where("payments.payed_at BETWEEN ? AND ?", @start_date, @end_date).sum(:amount)
    else
      # expenses
      @expenses[:teachers] = Expense.of_branch(current_user.branch_id).joins(:teacher).group(:teacher_id).
          where("expenses.expended_at BETWEEN ? AND ?", @start_date, @end_date).
          select("CONCAT(teachers.name,' ',teachers.surname) AS teacher_name, SUM(expenses.amount) AS amount")
      @expenses[:holes] = Expense.of_branch(current_user.branch_id).joins(:hole).group(:hole_id).
          where("expenses.expended_at BETWEEN ? AND ?", @start_date, @end_date).
          select("holes.name AS hole_name, SUM(expenses.amount) AS amount")
      @expenses[:others] = Expense.of_branch(current_user.branch_id).group(:note).
          where("hole_id IS NULL AND teacher_id IS NULL").
          where("expenses.expended_at BETWEEN ? AND ?", @start_date, @end_date).
          select("note, SUM(amount) AS amount")


      # payments
      @payments[:students] = Payment.of_branch(current_user.branch_id).joins(:student).group(:student_id).
          where("payments.payed_at BETWEEN ? AND ?", @start_date, @end_date).
          select("CONCAT(students.name,' ',students.surname) AS student_name, SUM(payments.amount) AS amount")
      @payments[:ort_participants] = Ort::Payment.of_branch(1).joins(:participant).group(:participant_id).
          where("ort_payments.created_at BETWEEN ? AND ?", @start_date, @end_date).
          select("ort_participants.name AS participant_name, SUM(ort_payments.amount) AS amount")
      @payments[:sources] = Payment.of_branch(current_user.branch_id).joins(:source).group(:source_id).
          where("payments.payed_at BETWEEN ? AND ?", @start_date, @end_date).
          select("sources.name AS source_name, SUM(payments.amount) AS amount")
      @payments[:others] = Payment.of_branch(current_user.branch_id).group(:note).
          where("source_id IS NULL AND student_id IS NULL").
          where("payments.payed_at BETWEEN ? AND ?", @start_date, @end_date).
          select("note, SUM(amount) AS amount")
    end

  end

  private

  def difference(payments, ort_payments, expenses)
    difference = {}
    payments.each { |p| difference[p.branch_id] = p.total_amount }
    ort_payments.each { |p| difference[p.branch_id] = difference[p.branch_id].to_i + p.total_amount }
    expenses.each { |e| difference[e.branch_id] = difference[e.branch_id].to_i - e.total_amount }
    difference
  end
end
