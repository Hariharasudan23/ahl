class RenamePhotoUrlPhotos < ActiveRecord::Migration
  def change
    rename_column :photos, :photo_url, :picture
  end
end
