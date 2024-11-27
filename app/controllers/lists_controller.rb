class ListsController < ApplicationController

  def new
    @list = List.new
    @tasks = Task.new
  end

  def show
    @list = List.find(params[:id])
  end

  def create
    # raise
    @list = List.new(list_params)
    @list.user = current_user
    @list.save
    redirect_to list_path(@list)
  end

  private

  def list_params
    params.require(:list).permit(:name, :category)
  end
end
