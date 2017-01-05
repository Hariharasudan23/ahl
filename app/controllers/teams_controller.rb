class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:show, :index]

  def show
    @other_teams = @team.tournament_opponents
    @top_scorers = @team.players.order(goals_count: :desc).limit(4)

    # Team's matches
    @recent_matches = @team.recent_matches
    @upcoming_matches = @team.upcoming_matches

    # Team stats
    @wins = @team.total_wins(@other_teams)
    @draws = @team.total_draws(@other_teams)
    @losses = @team.total_losses(@other_teams)
  end

  def index
    @teams = Team.all
    respond_to do |format|
      format.json
    end
  end

  def new
    @team = Team.new
  end

  def edit; end

  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html {
          redirect_to @team, notice: 'Team was successfully created.'
        }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html {
          redirect_to @team, notice: 'Team was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html {
        redirect_to teams_url, notice: 'Team was successfully destroyed.'
      }
      format.json { head :no_content }
    end
  end

  private
    def set_team
      @team = Team.friendly.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :motto, :points)
    end
end
