json.id @match.id
json.team1 @match.first_team.name
json.team2 @match.opponent_team.name
json.live_score @match.live_scores.last
json.running @match.running
json.report @match.report[0]
json.man_of_the_match @match.man_of_the_match
json.budding_player @match.trump_card
