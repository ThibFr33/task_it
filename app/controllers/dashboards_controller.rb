class DashboardsController < ApplicationController
  def index
    @list = List.new
  end
  #Ex:- add_index("admin_users", "username")
end
