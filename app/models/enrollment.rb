class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user, presence: true, uniqueness: { scope: :course }
  validates :course, presence: true, uniqueness: { scope: :user }
  validates :role, presence: true

  def learner?
    role == "learner"
  end

  def leader?
    role == "leader"
  end
end
