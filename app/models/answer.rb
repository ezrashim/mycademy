class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :enrollment

  validates :answer, presence: true
  validates :question_id, presence: true
  validates :enrollment_id, presence: true
end
