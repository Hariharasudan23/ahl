class StaticPagesController < ApplicationController
  def home
      @reports = Report.order(created_at: :desc).limit(4)
      @photos = Photo.order(created_at: :desc).limit(5)
      @teams = Team.order(points: :desc)
      @current_match = Match.where(result: -2).first
      @live_score = @current_match.live_scores.last

      @top_scorers = Player.order("goals_count desc").limit(4)
      @matches_ended = Match.where("result <> -2").count
  end

  def about
  end
end
