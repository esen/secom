class Group < ActiveRecord::Base
  belongs_to :level
  has_many :students, :dependent => :destroy
  has_many :payment_dates, :dependent => :destroy

  attr_accessible :finished_at, :level_id, :name, :started_at, :active, :price

  def payment_dates_valid?
    if self.active?
      self.payment_dates.each do |pd|
        if self.started_at > pd.payment_date
          return false
        end
      end

      if self.payment_dates.sum(:amount) != self.price
        return false
      end
    end

    true
  end
end
