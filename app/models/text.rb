class Text < ActiveRecord::Base
  belongs_to :enrollment

  validates :text, presence: true
end 
