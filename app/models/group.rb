class Group < ActiveRecord::Base
  belongs_to :level

  attr_accessible :finished_at, :level_id, :name, :started_at
end
