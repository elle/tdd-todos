class TodosController < ApplicationController
  def index
    @todos = Todo.all
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      flash[:info] = "You've created a todo successfully"
      redirect_to root_path
    else
      flash[:warning] = "Cannot create todo"
      redirect_to root_path
    end
  end

  private

  def todo_params
    params[:todo].permit(:description)
  end
end
