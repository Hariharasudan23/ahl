class LiveScoresController < ApplicationController
  before_action :set_match, except: [:broadcast]
  before_action :authenticate

  def index
      @live_scores = @match.live_scores.order(created_at: :desc)
      @live_score = @match.live_scores.new
  end


  def create

    @live_score = @match.live_scores.new(live_score_params)
    if @live_score.save
        redirect_to match_live_scores_url(@match), notice: 'Live score was successfully created.'
    else
        redirect_to match_live_scores_url(@match), alert: "Couldn't update. Fill all the fields and try again"
    end

  end

  def broadcast
      @current_match =  Match.where(result: -2).first
      @live_score = @current_match.live_scores.order(created_at: :desc).first

      render :json => @live_score
  end


  def destroy

      @live_score = @match.live_scores.find(params[:id])
      @live_score.destroy
      redirect_to match_live_scores_url(@match), notice: 'Live score was successfully destroyed.'
  end

  private
    def set_match
        @match = Match.friendly.find(params[:match_id])
    end

    def live_score_params
      params.require(:live_score).permit(:teamone_goals, :teamtwo_goals,:commentary)
    end

    def authenticate
        authenticate_or_request_with_http_basic("Trespassers will be prosecuted") do |username, password|
            username == ENV['USERNAME'] and password == ENV['ADMIN_PASSWORD']
       end
    end

end
