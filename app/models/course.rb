class Course < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_title, :against => :title
  has_many :enrollments
  has_many :lessons
  has_many :users, through: :enrollments

  validates :title, presence: true
  validates :description, presence: true
  validates :passcode, presence: true
end
