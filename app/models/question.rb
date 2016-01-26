class Question < ActiveRecord::Base
  belongs_to :lesson

  validates :description, presence: true
  validates :lesson_id, presence: true
end
