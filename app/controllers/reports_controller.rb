class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def main

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


    # expenses
    @expenses[:teachers] = Expense.joins(:teacher).group(:teacher_id).
        where("expenses.expended_at BETWEEN ? AND ?", @start_date, @end_date).
        select("CONCAT(teachers.name,' ',teachers.surname) AS teacher_name, SUM(expenses.amount) AS amount")
    @expenses[:holes] = Expense.joins(:hole).group(:hole_id).
        where("expenses.expended_at BETWEEN ? AND ?", @start_date, @end_date).
        select("holes.name AS hole_name, SUM(expenses.amount) AS amount")
    @expenses[:others] = Expense.group(:note).
        where("hole_id IS NULL AND teacher_id IS NULL").
        where("expenses.expended_at BETWEEN ? AND ?", @start_date, @end_date).
        select("note, SUM(amount) AS amount")


    # payments
    @payments[:students] = Payment.joins(:student).group(:student_id).
        where("payments.payed_at BETWEEN ? AND ?", @start_date, @end_date).
        select("CONCAT(students.name,' ',students.surname) AS student_name, SUM(payments.amount) AS amount")
    #@payments[:ort_participants] = Payment.group(:ort_participant_id).
    #    where("payments.payed_at BETWEEN ? AND ?", @start_date, @end_date).
    #    select("ort_participants.name AS participant_name, SUM(payments.amount) AS amount")
    @payments[:sources] = Payment.joins(:source).group(:source_id).
        where("payments.payed_at BETWEEN ? AND ?", @start_date, @end_date).
        select("sources.name AS source_name, SUM(payments.amount) AS amount")
    @payments[:others] = Payment.group(:note).
        where("source_id IS NULL AND student_id IS NULL AND ort_participant_id IS NULL").
        where("payments.payed_at BETWEEN ? AND ?", @start_date, @end_date).
        select("note, SUM(amount) AS amount")
  end
end
