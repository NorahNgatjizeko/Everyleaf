class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
PER = 5
  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
      if params[:sort_expired]
       @tasks = Task.all.order('deadline DESC').page params[:page]
   elsif params[:task_name].present?
     if params[:status].present?
      @tasks = Task.all.task_name_search(params[:task_name]).status_search(params[:status]).page params[:page]
    else
      @tasks = Task.all.task_name_search(params[:task_name]).page params[:page]
    end
  elsif params[:status].present?
      @tasks = Task.all.status_search(params[:status]).page params[:page]
  elsif params[:sort_priority]
      @tasks = Task.all.priority_ordered.page params[:page]
  else
      @tasks = Task.all.order('created_at DESC').page params[:page]
      @tasks = @tasks.order(created_at: :desc).page(params[:page]).per(PER)
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:task_name,:description,:status, :priority, :deadline)
    end
end
