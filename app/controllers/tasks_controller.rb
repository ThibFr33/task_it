class TasksController < ApplicationController

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to root_path
  end

  def update
    @task = Task.find(params[:id])
    @list = @task.list
    @task.update(task_params)
    redirect_to list_path(@list)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  def ocr

  end

  private

  def task_params
    params.require(:task).permit(:done)
  end
end
