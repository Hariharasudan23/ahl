class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  # GET /goals
  # GET /goals.json
  def index
    @goals = Goal.all
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(goal_params)

    respond_to do |format|
      if @goal.save

          #when a goal is created, the goals count from the player record has to be incremented
          @player = @goal.player
          goal_count = @player.goals_count
          @player.update_attributes(goals_count: goal_count + 1)

        format.html { redirect_to @goal, notice: 'Goal was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
        format.json { render :show, status: :created, location: @goal }
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy

      #when a goal is deleted, the goals count from the player record has to be decremented
    @player = @goal.player
    goal_count = @player.goals_count
    @goal.destroy
    @player.update_attributes(goals_count: goal_count - 1)
    respond_to do |format|
      format.html { redirect_to goals_url, notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:match_id, :player_id, :opponent_id)
    end
end