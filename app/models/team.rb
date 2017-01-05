class Team < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :players, dependent: :destroy
  has_many :goals, through: :players

  scope :men, -> { where(gender: 'm') }
  scope :women, -> { where(gender: 'f') }

  # helper for collection_select
  def team_name
    name.downcase.capitalize
  end

  def men?
    gender == 'm'
  end

  def tournament_opponents
    men? ? Team.men.where.not(id: id) : Team.women.where.not(id: id)
  end

  def team_captain
    Player.find(captain)
  end

  # Returns the number of matches ended between two teams
  def matches(opponent_id)
    @matches = []
    m = Match.where(team1_id: [id, opponent_id], team2_id: [id, opponent_id])
    m.each do |match|
      @matches << match if match.result != -2
    end
    @matches
  end

  # Returns the number of matches a team has player_id
  def matches_played
    Match.where('(team1_id = ? OR team2_id = ?) AND result <> ?', id, id, -2)
      .count
  end

  # Returns the recent 4 matches, to display team's recent performance
  def recent_matches
    Match.where('(team1_id=? OR team2_id=?) AND result<>?', id, id, -2)
      .order(id: :desc).limit(4)
  end

  # Upcoming matches for teams
  def upcoming_matches
    Match.where('(team1_id=? OR team2_id=?) AND result=?', id, id, -2).limit(4)
  end

  # Returns the goals scored by versus team versus opponent
  def goals_scored(opponent_id)
    Goal.where(player_id: players, opponent_id: opponent_id).count
  end

  # Returns the number of draws against a team
  def draws_count(opponent_id)
    matches = matches(opponent_id)
    draws = 0

    matches.each do |match|
      draws += 1 if match.result.zero?
    end
    draws
  end

  # Returns the number of wins a team has over another team, naive approach
  def wins_count(opponent_id)
    matches = matches(opponent_id)
    wins = 0

    matches.each do |match|
      if id == match.team1_id
        wins += 1 if match.result == 1
      elsif id == match.team2_id
        wins += 1 if match.result == -1
      end
    end
    wins
  end

  def losses_count(opponent_id)
    matches = matches(opponent_id)
    matches.length - wins_count(opponent_id) - draws_count(opponent_id)
  end

  # Methods for pie charts
  def total_wins(opponent_teams)
    wins = 0
    opponent_teams.each do |team|
      wins += wins_count(team.id)
    end
    wins
  end

  def total_losses(opponent_teams)
    losses = 0
    opponent_teams.each do |team|
      losses += losses_count(team.id)
    end
    losses
  end

  def total_draws(opponent_teams)
    draws = 0
    opponent_teams.each do |team|
      draws += draws_count(team.id)
    end
    draws
  end
end
