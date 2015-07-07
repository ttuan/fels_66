class Lesson < ActiveRecord::Base
  included ActivityLog

  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy

  after_create :create_learned_activity
  
  private
  def create_learned_activity
    create_activity user_id, id, Settings.learned
  end
end
