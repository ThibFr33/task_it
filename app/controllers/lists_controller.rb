require "openai"
require "json"

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
    redirect_to list_paths, status: :see_other
  end

  def ocr
    @photo = encode_image
    client = OpenAI::Client.new
    messages = [
      { "type": "text", "text": "Je t'écris en français tu me réponds en français.
                                 Je t'envoies la photo d'une to do list.
                                 La photo est celle d'un document papier avec une écriture à la main.
                                 Tu extraits chaque item séparemment. Si tu n'es pas sûr d'un item trouve la
                                 correspondance française la plus proche."},
      { "type": "image_url",
        "image_url": {
          "url": "data:image/jpeg;base64,#{@photo}",
        },
      }
    ]

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini", # Required.
        response_format: "json",
        messages: [
          { role: "user", content: messages }
        ] # Required.
      }
    )
    raise
    response
    # client.chat.completions.create(
    #       model="gpt-4-vision-preview",
    #       messages=[
    #         {
    #           "role": "user",
    #           "content": [
    #             {
    #               "type": "text",
    #               "text": "Je t'écris en français tu me réponds en français.
    #              Je t'envoies la photo d'une to do list. La photo est celle d'un document papier avec une écriture à la main.
    #             Tu extraits chaque item séparemment. Si tu n'es pas sûr d'un item trouve la correspondance française la plus proche.",
    #             },
    #             {
    #               "type": "image_url",
    #               "image_url": {
    #                 "url":  f"data:image/jpeg;base64,{base64_image}"
    #               },
    #             },
    #           ],
    #         }
    #       ],
    #     )
        return response.choices[0]
  end

  def encode_image
    file_content = File.read(params[:ocr][:temp_photo].tempfile)
    Base64.strict_encode64(file_content)
  end

  private

  def list_params
    params.require(:list).permit(:name, :category)
  end
end
