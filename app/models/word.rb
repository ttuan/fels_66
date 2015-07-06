class Word < ActiveRecord::Base
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :alphabet, presence: true, length: {maximum: Settings.maximum_alphabet_length}
end
