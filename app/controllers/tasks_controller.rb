class TasksController < ApplicationController

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to root_path
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

end
