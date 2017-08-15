class TodosController < ApplicationController
  before_action :authenticate

  def index
    @todos = Todo.all
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      twilio_client.messages.create(
        body: todo_params[:description],
        to: "+13025306878",
        from: ENV.fetch("TWILIO_FROM_NUMBER"),
      )
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
