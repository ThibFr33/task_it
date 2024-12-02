class List < ApplicationRecord
  enum category: { autre: 0, courses: 1, vacances: 2, maison: 3, administratif: 4, enfants: 5 }


  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :name, :category, presence: true

  def order_by_done_tasks
    tasks.order(done: :asc)
  end

  # private

  # def set_content
  #   OcrListJob.perform_later(self)
  # end
end
