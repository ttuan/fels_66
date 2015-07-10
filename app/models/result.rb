class Result < ActiveRecord::Base
  belongs_to :word
  belongs_to :lesson

  scope :correct_answers, ->{where(status: true)}
end
