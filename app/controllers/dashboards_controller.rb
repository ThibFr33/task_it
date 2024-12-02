class DashboardsController < ApplicationController
  def index
    @list = List.new
    @last_lists = current_user.lists.last(3)
    @reminders = current_user.reminders.order(:end_date).where("DATE(end_date) = ?", Date.current)
  end
end
