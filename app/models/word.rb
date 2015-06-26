class Word < ActiveRecord::Base
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
end
