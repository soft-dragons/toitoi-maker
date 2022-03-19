class Problem < ApplicationRecord

  has_many :feedbacks, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 60 }
  validates :statement, presence: true, length: { maximum: 1000 }
  validates :answer, presence: true, length: { maximum: 30 }
  validates :incorrect1, presence: true, length: { maximum: 30 }
  validates :incorrect2, presence: true, length: { maximum: 30 }

  def answer_check
    if self.answer == self.incorrect1
      return false
    elsif self.answer == self.incorrect2
      return false
    elsif self.incorrect1 == self.incorrect2
      return false
    else
      return true
    end
  end
end