class Match < ActiveRecord::Base
	extend FriendlyId
	friendly_id :match_url, use: :slugged

	# returns readable format of url
	def match_url
		self.first_team.name + " vs " + self.opponent_team.name + " " + self.time.strftime("%b %d")
	end


	def should_generate_new_friendly_id?

	end
	# Associations
	has_many :teams
	has_many :goals, dependent: :destroy
	has_many :live_scores, dependent: :destroy
	has_many :photos, dependent: :destroy
	has_one :report

	# Validations

	validates :result, presence: true, inclusion: {in: [-2, -1, 0, 1]}
	validate :different_teams
	#validate :wrong_player
	validates :team1_id, presence: true
	validates :team2_id, presence: true
	## don't uncomment the below two lines since the validations would fire up in other forms
	#validates :trump_card, presence: true, numericality: true
	#validates :man_of_the_match, presence: true, numericality: true


	# To retrieve the report associated with a match
	def report
		Report.where(match_id: self.id)
	end

	#Retriving the teams of a particular match
	def first_team
			Team.find(self.team1_id)
	end

	def opponent_team
			Team.find(self.team2_id)
	end

	def ended?
		self.result != -2
	end

	def winner
		result = self.result
		if result != -2
			case result
				# First team's the winner
			when 1
				final_result = Team.find(self.team1_id).name
			when -1
				final_result = Team.find(self.team2_id).name
			when 0
				final_result = "Draw"
			end

			# Match hasn't started yet
		else
			final_result = "Match yet to start"
		end
		final_result
	end

	# Custom validations

	def different_teams
		if self.team1_id == self.team2_id
			errors.add(:team2_id,"can't be the same as Team1")
		end
	end

	# Man of the match should belong to one of the teams of the match
	#Have to think !
	#def wrong_player
	#	team = Player.find(self.man_of_the_match).team_id
	#	if team != self.team1_id and team != self.team2_id
	#		errors.add(:man_of_the_match, "should belong to one of the two teams. Check the man_of_the_match id")
	#	end
	#end

end
