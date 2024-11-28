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

  def create
    @list = List.new(list_params)
    @list.user = current_user
     if @list.save
       redirect_to list_path(@list)
     else
       render "dashboards/index", status: :unprocessable_entity
     end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to list_paths, status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, :category)
  end
end
