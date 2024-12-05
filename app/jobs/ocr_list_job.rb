class OcrListJob < ApplicationJob
  queue_as :default

  def perform(photo, list)
    tasks_list = OcrList.new(photo).call
    tasks_list["tasks"].each do |label|
      task = Task.create!(label: label, list: list)
    end

    Turbo::StreamsChannel.broadcast_update_to(
      "list_#{list.id}",
      target: "list_#{list.id}-tasks",
      partial: "lists/list_tasks", locals: { list: list })


    Turbo::StreamsChannel.broadcast_remove_to(
      "list_#{list.id}",
      target: "loader",
      partial: "shared/loader")

  end
end
