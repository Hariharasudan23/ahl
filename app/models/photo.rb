class Photo < ActiveRecord::Base
  belongs_to :match
  validates :picture, presence: true

  mount_uploader :picture, PictureUploader
end
