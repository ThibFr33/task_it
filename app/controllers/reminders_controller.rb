require "open-uri"

class RemindersController < ApplicationController

  def index
    @reminders = current_user.reminders.order(:end_date).where("DATE(end_date) >= ?", Date.current)
    @reminder = Reminder.new

  end

  def new
    @reminder = Reminder.new
  end

  def show
    @reminder = Reminder.find(params[:id])
    @hour = @reminder.end_date.hour
    @minutes = @reminder.end_date.min
  end

  def create
    @reminder = Reminder.new(reminder_params)
    unless reminder_params[:end_date].empty? && params[:hours].empty?
      end_date = DateTime.parse("#{reminder_params[:end_date]} #{params[:hours]}")
      @reminder.end_date = end_date
    end
    @reminder.user = current_user
    if @reminder.save
      redirect_to reminders_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @reminder = Reminder.find(params[:id])
    @hour = @reminder.end_date.hour
    @minutes = @reminder.end_date.min
  end

  def update
    @reminder = Reminder.find(params[:id])
    if @reminder.update(description: params[:reminder][:description], end_date: DateTime.parse("#{params[:reminder][:end_date]} #{params[:hours]}"))
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy
    redirect_to reminders_path
  end

  def ocr
    ocr_result = OcrReminder.new(params[:ocr][:temp_photo]).call
    # OcrListJob.perform_later(params[:ocr][:temp_photo],@reminder)
    end_date = correct_and_convert_date(ocr_result.first["end_date"])
    @reminder = Reminder.new(description: ocr_result.first["description"], end_date: end_date)
    @reminder.user = current_user
    if @reminder.save
      redirect_to reminders_path
    else
      flash.alert = "Une erreur est survenue"
    end
  end

  private

  def reminder_params
    params.require(:reminder).permit(:description, :end_date, :hours)
  end

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
