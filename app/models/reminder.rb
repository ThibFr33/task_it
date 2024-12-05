class Reminder < ApplicationRecord
  belongs_to :user

  validates :description, presence: true, on: :update
  validates :end_date, presence: true, on: :update

  scope :order_by_date, -> { order(:end_date).where("DATE(end_date) >= ?", Date.current) }

  # def order_by_hour_reminders
  #   reminders.order(DateTime.hour: :asc)
  # end

end
