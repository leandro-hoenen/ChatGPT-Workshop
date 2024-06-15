class ScenariosController < ApplicationController
  before_action :set_scenario, only: %i[ show edit update destroy start evaluations ]
  before_action :authenticate_user!
  before_action :check_lecturer, only: [:new, :create, :edit, :update, :destroy]

  # Start the evaluation process
  def start
    @task = @scenario.tasks.first
    if @task
      redirect_to new_scenario_task_evaluation_path(@scenario, @task)
    else
      redirect_to scenario_path(@scenario), notice: 'No tasks available for this scenario'
    end
  end

  # GET /scenarios or /scenarios.json
  def index
    @scenarios = Scenario.all
  end

  # GET /scenarios/1 or /scenarios/1.json
  def show
  end

  # GET /scenarios/new
  def new
    @scenario = Scenario.new
  end

  # GET /scenarios/1/edit
  def edit
  end

  # POST /scenarios or /scenarios.json
  def create
    @scenario = Scenario.new(scenario_params)

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to scenarios_url, notice: "Scenario was successfully created." }
        format.json { render :show, status: :created, location: @scenario }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scenarios/1 or /scenarios/1.json
  def update
    respond_to do |format|
      if @scenario.update(scenario_params)
        format.html { redirect_to scenario_url(@scenario), notice: "Scenario was successfully updated." }
        format.json { render :show, status: :ok, location: @scenario }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenarios/1 or /scenarios/1.json
  def destroy
    @scenario.destroy!

    respond_to do |format|
      format.html { redirect_to scenarios_url, notice: "Scenario was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def evaluations
    # This line retrieves all tasks associated with a specific scenario, including their evaluations. It does so by:
    # 1. Preloading the evaluations for each task to optimize query performance and avoid N+1 query issues.
    # 2. Ordering the tasks by their ID in ascending order to ensure a consistent sequence.
    # 3. Mapping over each task to create a new array where each element is a two-element array:
    #    - The first element is the task itself.
    #    - The second element is an array of the task's evaluations, ordered by their creation date in ascending order.
    # The result is assigned to @evaluations_by_task, providing a structured representation of tasks and their evaluations.
    # @tasks = @scenario.tasks 
    @evaluations_by_task = @scenario.tasks.includes(:evaluations).order(:id).map { |task| [task, task.evaluations.order(:created_at)] }
    
    if @evaluations_by_task.empty?
      redirect_to scenarios_path, notice: 'No evaluations available for this scenario'
    end
  end

  private
    def check_lecturer
      unless current_user.lecturer?
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Not authorized" }
        format.json { head :no_content }
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_scenario
      @scenario = Scenario.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def scenario_params
      params.require(:scenario).permit(:name, :description)
    end
end
