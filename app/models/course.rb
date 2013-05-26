class Course < ActiveRecord::Base
  belongs_to :branch
  belongs_to :group
  belongs_to :lesson
  belongs_to :teacher
  belongs_to :course_time
  belongs_to :room

  after_save :calculate_capacity_of_group
  after_destroy :calculate_capacity_of_group

  attr_accessible :branch_id, :course_time_id, :friday, :group_id, :lesson_id, :monday, :room_id, :saturday, :sunday, :teacher_id, :thursday, :tuesday, :wednesday

  scope :of_branch, lambda { |branch_id| where(:branch_id => branch_id) }
  scope :of_group, lambda { |group_id| where(:group_id => group_id) }
  scope :of_lesson, lambda { |lesson_id| where(:lesson_id => lesson_id) }
  scope :of_teacher, lambda { |teacher_id| where(:teacher_id => teacher_id) }
  scope :of_course_time, lambda { |course_time_id| where(:course_time_id => course_time_id) }
  scope :of_room, lambda { |room_id| where(:room_id => room_id) }


  def calculate_capacity_of_group
    g = self.group
    g.capacity = g.courses.joins(:room).select("rooms.capacity").collect { |r| r.capacity }.min
    g.save
  end
end
