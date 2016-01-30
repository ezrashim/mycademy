class Lesson < ActiveRecord::Base
  belongs_to :course
  has_many :questions

  validates :title, presence: true
  validates :content, presence: true
  validates :lesson_no, presence: true, uniqueness: { scope: :course }
end
