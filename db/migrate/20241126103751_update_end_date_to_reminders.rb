class UpdateEndDateToReminders < ActiveRecord::Migration[7.1]
  def change
    change_column :reminders, :end_date, :datetime
  end
end
