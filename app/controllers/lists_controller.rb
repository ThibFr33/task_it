require "open-uri"

class ListsController < ApplicationController

  def index
    @lists = current_user.lists
  end

  def new
    @list = List.new
    @tasks = Task.new
  end

  def show
    @list = List.find(params[:id])
    @task_new = Task.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
     if @list.save
       redirect_to list_path(@list)
     else
       render "dashboards/index", status: :unprocessable_entity
     end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to list_path, status: :see_other
  end

  def ocr
    @list = List.find(params[:id])
    Turbo::StreamsChannel.broadcast_update_to(
      "list_#{@list.id}",
      target: "loader",
      partial: "shared/loader")

    photo = encode_image(params[:ocr][:temp_photo])
    OcrListJob.perform_later(photo, @list)
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    @list.update(list_params)
    redirect_to list_path(@list)
  end

  private

  def encode_image(photo)
    file_content = File.read(photo.tempfile)
    Base64.strict_encode64(file_content)
  end

  def list_params
    params.require(:list).permit(:name, :category)
  end
end
