class TasksController < ApplicationController
	def index
		@tasks = Task.all
		@task = Task.new
	end

	def create
		@task = Task.new(task_params)
			respond_to do |format|
			  if @task.save
				format.html { redirect_to tasks_url, notice: "Added to wishlist" }
			  else
				format.html { render :new, status: :unprocessable_entity }
			end
		end
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		respond_to do |format|
			if @task.update(task_params)
				format.html { redirect_to tasks_url, notice: "Item updated"}
			else
				format.html { render :edit, status: :uprocessable_entity }
			end
		end
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		redirect_to tasks_url, notice: "Item deleted"
	end

	private

	def task_params
		params.require(:task).permit(:description)
	end

	def toggle
		@task = Task.find(params[:id])
		@task.update(completed: params[:completed])
		render json: { message: "Success" }
	end

end