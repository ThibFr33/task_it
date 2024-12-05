require "open-uri"

class RemindersController < ApplicationController

  def index
    @reminders = current_user.reminders.order_by_date
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
    @reminder = Reminder.create!(user: current_user)
    Turbo::StreamsChannel.broadcast_append_to(
      "reminder-index",
      target: "loader",
      partial: "shared/loader")

    OcrReminderJob.perform_now(@reminder, encode_image(params[:ocr][:temp_photo]), current_user)
  end
  private

  def reminder_params
    params.require(:reminder).permit(:description, :end_date, :hours)
  end

  def encode_image(photo)
    file_content = File.read(photo.tempfile)
    Base64.strict_encode64(file_content)
  end

end
