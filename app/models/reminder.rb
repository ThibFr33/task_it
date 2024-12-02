class Reminder < ApplicationRecord
  belongs_to :user

  validates :description, presence: true
  validates :end_date, presence: true

  # def order_by_hour_reminders
  #   reminders.order(DateTime.hour: :asc)
  # end

end
