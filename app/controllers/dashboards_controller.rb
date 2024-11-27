class DashboardsController < ApplicationController
  def index
    @list = List.new
    @last_lists = List.last(3)
    @reminders = Reminder.all
  end
end