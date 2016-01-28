class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :enrollment

  validates :answer, presence: true
  validates :question, presence: true, uniqueness: { scope: :enrollment }
  validates :enrollment, presence: true, uniqueness: { scope: :question }
end
