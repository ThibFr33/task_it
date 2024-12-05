class OcrReminderJob < ApplicationJob
  queue_as :default

  def perform(reminder, photo, current_user)

    ocr_result = OcrReminder.new(photo).call
    end_date = correct_and_convert_date(ocr_result.first["end_date"])
    reminder.update(description: ocr_result.first["description"], end_date: end_date)
    reminders = current_user.reminders.order_by_date

    Turbo::StreamsChannel.broadcast_update_to(
      "reminder-index",
      target: "reminder-list",
      partial: "reminders/reminders",
      locals: { reminders: reminders })

    Turbo::StreamsChannel.broadcast_remove_to(
      "reminder-index",
      target: "loader",
      partial: "shared/loader")

  end

  private

  def correct_and_convert_date(input_date)
    return nil if input_date.blank?

    begin # Parse the string manually
      date_parts = input_date.split("T").first.split("-").map(&:to_i)
      time_parts = input_date.split("T").last.split(":").map(&:to_i)

      # Extract and normalize date components
      year, month, day = date_parts
      hour, minute = time_parts

      # Handle invalid months and days
      if month > 12
        month = 12
        day = [day, 31].min
      end

      # Create a valid DateTime object
      DateTime.new(year, month, day, hour, minute)
    rescue ArgumentError => e
      nil
      # Return nil if the conversion fails
    end
  end
end
