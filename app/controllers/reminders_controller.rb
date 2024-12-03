class RemindersController < ApplicationController

  def index
    @reminders = current_user.reminders.where("DATE(end_date) >= ?", Date.current)
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

  private

  def reminder_params
    params.require(:reminder).permit(:description, :end_date)
    params.require(:reminder).permit(:description, :hours)
  end
end
