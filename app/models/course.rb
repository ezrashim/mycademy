class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :lessons
  has_many :users, through: :enrollments

  validates :title, presence: true
  validates :description, presence: true
end
