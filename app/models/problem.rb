class Problem < ApplicationRecord

  has_many :feedbacks, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :user

end
