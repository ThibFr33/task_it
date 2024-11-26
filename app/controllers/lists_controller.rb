class ListsController < ApplicationController

  def new
    @list = List.new
    @tasks = Task.new
  end

  def show
    @list = List.find(params[:id])
  end
end
