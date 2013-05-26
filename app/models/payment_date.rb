# encoding: utf-8

class PaymentDate < ActiveRecord::Base
  belongs_to :branch
  belongs_to :group

  attr_accessible :amount, :group_id, :payment_date, :branch_id
  validates_presence_of :amount, :group, :payment_date, :branch_id
  validate :validate_payment_date
  validate :validate_amount
  validate :validate_group

  before_destroy :validate_group

  scope :of_group, lambda { |group_id| where(:group_id => group_id) }
  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }

  def validate_payment_date
    if self.payment_date && self.payment_date.year > 2100
      self.errors.add(:payment_date, "Дата туура эмес берилди")
    end
  end

  def validate_amount
    if self.amount <= 0
      self.errors.add(:amount, "Суммасы нольдон жогору болушу керек")
    end
  end

  def validate_group
    if group.active?
      total = group.payment_dates.sum(:amount) + self.amount

      if self.payment_date < group.started_at
        self.errors.add(:payment_date, "Төлөө датасы курстун башталышынан эрте болбойт")
      end

      group.payment_dates.each do |pd|
        if self.payment_date == pd.payment_date
          self.errors.add(:group, "Мындай дата мурда кошулган")
          break
        end
      end

      if total != group.price
        self.errors.add(:amount, "Суммасы курстун наркына барабар болушу керек")
      end
    end
  end
end
