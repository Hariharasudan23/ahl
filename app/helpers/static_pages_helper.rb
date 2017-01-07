module StaticPagesHelper
  def first_name(name)
    name.split(' ')[0]
  end

  def short_form(name)
    name.split(' ')[-1]
  end

  def rules_women
    [
      'The game is equally divided into 4 rounds with a period of 10 minutes each.',
      'Each team consists of maximum of 7 players on the field including one goal keeper.',
      'The playing sides will be changed in each round with a 2-minute break and a 3-minute between the second and third rounds'
    ]
  end

  def rules_men
    [
      'The game is equally divided into 6 rounds with a period of 10 minutes each.',
      'Each team consists of maximum of 9 players on the field including one goal keeper.',
      'Teams can have any number of bench players under the condition that each player should play at least two rounds.',
      'The playing sides will be changed in each round and each team will have one time out during each half and a 3-minute between third and fourth rounds.',
      'In the second and third rounds, teams should play with amateur players (3 first-years, 4 second-years and a third year player). Violation will lead to penalty stroke.',
      'In the fourth round, the team should play with all third year players.',
      'In case of any injuries in the second and third rounds, the player changed should be of the same year or junior as of injured player.',
      'Hitting the ball is only allowed inside their half while taking free hit.'
    ]
  end

  def common_rules
    [
      'Sweeping, tapping and slapping, scooping the ball is allowed.',
      'The goal needs to be scored only from the D-circle.',
      'The ball should be moved 5 yards from any place in taking a foul.',
      'Any appeal to the umpire can be done by the captain only.',
      'Only three defenders (including goal keeper) and four attackers are allowed in the penalty
       corner. In penalty corner, the defenders need to run from the goal post.',
      'The ball should be started in the 25 yards line if it crosses the back line.',
      'The size of the field is 70*50 yards.',
      'Field umpire decision is final.',
      'All players should wear proper uniform.'
    ]
  end
end
