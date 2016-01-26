class Question < ActiveRecord::Base
  belongs_to :lesson
  has_many :answers

  validates :question, presence: true
  validates :lesson_id, presence: true
end
