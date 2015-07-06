class Word < ActiveRecord::Base
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :alphabet, presence: true, length: {maximum: Settings.maximum_alphabet_length}

  scope :search_word, ->search{where "alphabet LIKE ?", "%#{search}%"}
  scope :recent, ->{order "created_at DESC"}
  scope :filter_category, ->category{where category_id: category if category.present?}
  scope :learned, ->user{where "id IN (SELECT word_id FROM results WHERE lesson_id IN 
                               (SELECT id FROM lessons WHERE user_id = ?))", user.id}
  scope :not_learned, ->user{where "id NOT IN (SELECT word_id FROM results WHERE lesson_id IN 
                                   (SELECT id FROM lessons WHERE user_id = ?))", user.id}
  scope :get_all, ->user{}
end
