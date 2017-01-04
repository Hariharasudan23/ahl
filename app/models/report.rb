class Report < ActiveRecord::Base
    belongs_to :match
    extend FriendlyId
    friendly_id :caption, use: :slugged

    mount_uploader :image, ImageUploader

    validates :article, presence: true
    validates :image, presence: true
    validates :caption, presence: true

    # for pagination
    self.per_page = 5
end
