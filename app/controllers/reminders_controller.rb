require "open-uri"

class RemindersController < ApplicationController

  def index
    @reminders = current_user.reminders
    @reminder = Reminder.new
  end

  def new
    @reminder = Reminder.new
  end

  def show
    @reminder = Reminder.find(params[:id])
  end

  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.user = current_user
    if @reminder.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy
    redirect_to reminder_paths
  end

  def ocr
    ocr_result = OcrReminder.new(params[:ocr][:temp_photo]).call
    # OcrListJob.perform_later(params[:ocr][:temp_photo],@reminder)
    @reminder = Reminder.new(description: ocr_result.first["description"], end_date: ocr_result.first["end_date"])
    @reminder.user = current_user
    if @reminder.save
      redirect_to reminder_path(@reminder)
    else
      flash.alert = "Une erreur est survenue"
    end
  end

  private

  def reminder_params
    params.require(:reminder).permit(:description, :end_date)
    params.require(:reminder).permit(:description, :hours)
  end
end
