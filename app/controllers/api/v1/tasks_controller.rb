# frozen_string_literal: true

class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: %i[show update destroy]

  def index
    render json: Task.order(created_at: :desc).all
  end

  def create
    @task = Task.new(task_params)
    if @task.invalid?
      render(json: @task.errors, status: 400)
    else
      @task.save!
      render json: @task
    end
  end

  def show
    render json: @task
  end

  def update
    if @task.update(task_params)
      render json: @task.reload
    else
      render(json: @task.errors, status: 400)
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def task_params
    params.permit(:title, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Task does not exist' }, status: :not_found
  end
end
