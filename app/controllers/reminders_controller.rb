class RemindersController < ApplicationController

  def index
    @reminders = current_user.reminders
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
    end_date = DateTime.parse("#{params[:end_date]} #{params[:hours]}")
    @reminder.end_date = end_date
    @reminder.user = current_user
    if @reminder.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @reminder = Reminder.find(params[:id])
    end_date = DateTime.parse("#{params[:end_date]} #{params[:hours]}")
    @reminder.end_date = end_date
    @reminder.user = current_user
      if @reminder.save
    redirect_to root_path
      else
        render :edit, status: :unprocessable_entity
      end
    end


  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy
    redirect_to reminder_paths
  end

  private

  def reminder_params
    params.require(:reminder).permit(:description, :end_date, :hours)
  end
end
