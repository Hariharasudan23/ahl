class RemoveDefaultPhotoFromPlayers < ActiveRecord::Migration
  def up
    change_column_default :players, :photo, nil
  end

  def down
    change_column_default :players, :photo, 'unknown.jpg'
  end
end
