class AddGenderToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :gender, :string, limit: 1, default: 'm'
  end
end
