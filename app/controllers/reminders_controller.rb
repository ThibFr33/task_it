class RemindersController < ApplicationController
  def new
    @reminder = Reminder.new
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

  private

  def reminder_params
    params.require(:reminder).permit(:description, :end_date)
    params.require(:reminder).permit(:description, :hours)
  end
end
