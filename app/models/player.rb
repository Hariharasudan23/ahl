class Player < ActiveRecord::Base
  belongs_to :team
  has_many :goals

  mount_uploader :photo, PhotoUploader
  #validations
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  validates :team_id, presence: true
  validates :position, presence: true
  validates :goals_count, presence: true, numericality: true
  validates :green_cards, presence: true, numericality: true
  validates :red_cards, presence: true, numericality: true
  validates :yellow_cards, presence: true, numericality: true
  validates :gender, presence: true, inclusion: { in: ['m', 'f'] }

  def goals
    Goal.where(player_id: self.id).count
  end
end
