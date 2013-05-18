# encoding: utf-8

class Group < ActiveRecord::Base
  belongs_to :branch
  belongs_to :level

  has_many :students, :dependent => :destroy
  has_many :payment_dates, :dependent => :destroy

  validates_presence_of :branch_id
  validate :payment_dates_valid?

  attr_accessible :finished_at, :level_id, :name, :started_at, :active, :price, :branch_id

  scope :not_finished, where(:finished_at => nil)
  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }

  def payment_dates_valid?
    if self.active?
      total = 0

      if self.started_at.nil?
        self.errors.add(:started_at, "Курстун башталышы көрсөтлүлгөн эмес")
      else
        self.payment_dates.each do |pd|
          total += pd.amount
          if self.started_at > pd.payment_date
            self.errors.add(:payment_dates, "Төлөө датасы курстун башталышынан эрте болбойт")
            return false
          end
        end

        if total != self.price
          self.errors.add(:payment_dates, "Суммасы курстун наркына барабар болушу керек")
          return false
        end
      end
    end

    true
  end
end
