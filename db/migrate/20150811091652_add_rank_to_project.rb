class AddRankToProject < ActiveRecord::Migration
  def change
    add_column :projects, :rank, :integer
  end
end
