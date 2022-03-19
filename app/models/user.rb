class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :problems, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  validates :name, presence: true, length: {maximum: 60}
  validates :point, numericality: {only_integer: true} #integerのみ許可

end
