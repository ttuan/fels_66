class Category < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy
  
  scope :ordered_by_create_at, ->{order "created_at DESC"}
  scope :search_category, ->search_category{where "name LIKE ?", "%#{search_category}%"}

  scope :learned, ->current_user_id{where "id IN (SELECT id FROM lessons 
                                          WHERE user_id = ?)", current_user_id}
  scope :not_learned, ->current_user_id{where "id NOT IN (SELECT id FROM lessons 
                                              WHERE user_id = ?)", current_user_id}
  scope :get_all, ->current_user_id{}

  validates :name, presence: true, length: {maximum: Settings.maximum_name_category_length}
end
