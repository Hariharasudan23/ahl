class StaticPagesController < ApplicationController
  def home
    @reports = Report.order(created_at: :desc).limit(4)
    @photos = Photo.order(created_at: :desc).limit(5)
    @men_teams = Team.men.order(points: :desc)
    @women_teams = Team.women.order(points: :desc)
    @current_match = Match.where(result: -2).first

    if @current_match
      @live_score = @current_match.live_scores.last
    end

    @men_top_scorers = Player.men.order(goals_count: :desc).limit(3)
    @women_top_scorers = Player.women.order(goals_count: :desc).limit(3)
    @matches_ended = Match.where.not(result: -2).count

    # static content
    @previous_top_scorers = Player.all.sample(3)
  end

  def about; end
end
