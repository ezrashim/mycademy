class Lesson < ActiveRecord::Base
  belongs_to :course

  validates :title, presence: true
  validates :content, presence: true
  validates :lesson_no, presence: true
end
