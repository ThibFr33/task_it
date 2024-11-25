class CreateReminders < ActiveRecord::Migration[7.1]
  def change
    create_table :reminders do |t|
      t.date :end_date
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
