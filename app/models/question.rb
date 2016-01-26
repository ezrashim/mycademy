class Question < ActiveRecord::Base
  belongs_to :lesson

  validates :question, presence: true
end
