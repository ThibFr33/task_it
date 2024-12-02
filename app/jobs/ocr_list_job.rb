class OcrListJob < ApplicationJob
  queue_as :default

  # def perform(photo, list)
  #   tasks_list = OcrList.new(photo).call
  #   tasks_list["tasks"].each do |task|
  #     Task.create!(label: task, list: list)
  #   end
  # end
end
