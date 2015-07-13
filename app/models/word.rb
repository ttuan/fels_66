class Word < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true, 
    reject_if: proc {|attributes| attributes[:ans].blank?}

  validates :alphabet, presence: true, length: {maximum: Settings.maximum_alphabet_length}

  scope :search_word, ->search{where "alphabet LIKE ?", "%#{search}%"}
  scope :recent, ->{order "created_at DESC"}
  scope :filter_category, ->category{where category_id: category if category.present?}
  scope :learned, ->current_user_id{where "id IN (SELECT word_id FROM results 
            WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id = ?))", current_user_id}
  scope :not_learned, ->current_user_id{where "id NOT IN (SELECT word_id FROM results 
            WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id = ?))", current_user_id}
  scope :get_all, ->current_user_id{}
  scope :random, ->{order "RANDOM()"}  

  def self.to_csv
    CSV.generate do |csv|
      csv << [t("word.word"), t("word.mean")]
      all.each do |word|
        word.answers.each do |a|  
          csv << [word.alphabet, a.ans] if a.status
        end
      end
    end
  end
end
