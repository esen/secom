# encoding: utf-8

class PaymentDate < ActiveRecord::Base
  belongs_to :group

  attr_accessible :amount, :group_id, :payment_date
  validates_presence_of :amount, :group
  validate :validate_amount
  validate :validate_group

  before_destroy :validate_group

  scope :of_group, lambda { |group_id| where(:group_id => group_id) }

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
