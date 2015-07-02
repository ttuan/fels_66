class Word < ActiveRecord::Base
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true
end
