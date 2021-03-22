class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    set_task
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = '正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  def edit
    set_task
  end
  
  def update
    set_task
    
    if @task.update(task_params)
      flash[:success] = 'タスクは更新されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    set_task
    @task.destroy
    
    flash[:success] = 'タスクは削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
end