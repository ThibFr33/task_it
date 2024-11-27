class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def new
    @list = List.new
    @tasks = Task.new
  end

  def show
    @list = List.find(params[:id])
  end
end
