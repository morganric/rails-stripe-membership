class AddFeedToProject < ActiveRecord::Migration
  def change
    add_column :projects, :feed, :boolean, :default => false
  end
end
