class Feedback < ApplicationRecord

  belongs_to :user
  belongs_to :problem

  validates :text, presence: true, length: { maximum: 1000}

end
