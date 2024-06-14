class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: %i[ show edit update destroy ]
  before_action :set_task, only: %i[ new create ]
  before_action :set_scenario, only: %i[ new create ]
  before_action :authenticate_user!

  # GET /evaluations or /evaluations.json
  def index
    @evaluations = Evaluation.all
  end

  # GET /evaluations/1 or /evaluations/1.json
  def show
  end

  # GET /evaluations/new
  def new
    @evaluation = Evaluation.new
  end

  # GET /evaluations/1/edit
  def edit
  end

  # POST /evaluations or /evaluations.json
  def create
    @evaluation = @task.evaluations.new(evaluation_params)
    @evaluation.task = @task

    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to next_scenario_task_path(@task.scenario, @task), notice: 'Evaluation was successfully created.' }
        format.json { render :show, status: :created, location: @evaluation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /evaluations/1 or /evaluations/1.json
  def update
    @tasks = Task.all
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to evaluation_url(@evaluation), notice: "Evaluation was successfully updated." }
        format.json { render :show, status: :ok, location: @evaluation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1 or /evaluations/1.json
  def destroy
    @evaluation.destroy!

    respond_to do |format|
      format.html { redirect_to evaluations_url, notice: "Evaluation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end

    def set_task
      @task = Task.find(params[:task_id])
      puts @task
    end

    def set_scenario
      @scenario = Scenario.find(params[:scenario_id])
    end

    # Only allow a list of trusted parameters through.
    def evaluation_params
      params.require(:evaluation).permit(:accuracy, :accuracy_description, :relevance, :relevance_description, :bias, :bias_description, :comments, :task_id)
    end
end
