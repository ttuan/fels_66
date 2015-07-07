class Activity < ActiveRecord::Base
  belongs_to :user

  scope :feed_all, ->(following_ids, user){where "user_id IN (?) OR user_id = ?", following_ids, user.id}
  scope :recent, ->{order "created_at DESC"}

  validates :status, presence: true
  validates :user_id, presence: true 
  validates :type_id, presence: true

  def type
    status == Settings.learned ? Lesson.find(type_id) : User.find(type_id)  
  end
end
