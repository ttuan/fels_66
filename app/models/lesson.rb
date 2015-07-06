class Lesson < ActiveRecord::Base
  include ActivityLog

  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results

  accepts_nested_attributes_for :results

  before_create :create_default
  after_create :create_learned_activity

  private
  def create_default
    Category.find(self.category_id).words.not_learned(self.user_id).
      random.limit(Settings.words_per_lesson).each do |w|
      self.results.build word_id: w.id, status: false 
    end
  end

  def create_learned_activity
    create_activity user_id, id, Settings.learned
  end
end
