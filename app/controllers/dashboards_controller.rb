class DashboardsController < ApplicationController
  def index
    @last_lists = List.last(3)
    @reminders = Reminder.all
  end
  #Ex:- add_index("admin_users", "username")
end
