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

  def calc_rate(problem)
    correct = problem.answers.where(result: true).size
    total = problem.answers.size
    #正当率
    if correct != 0 && total != 0
      rate = (correct * 100 / total)
    else
      rate = 0
    end
    rate
  end

  def divide_problems
    problems = Problem.all
    @high_level = []
    @medium_level = []
    @low_level = []

    problems.each do |problem|
      rate = calc_rate(problem)

      if rate >= 70
        @low_level.push(problem)
      elsif rate >= 40
        @medium_level.push(problem)
      else
        @high_level.push(problem)
      end
    end

    [@high_level, @medium_level, @low_level]
  end
end