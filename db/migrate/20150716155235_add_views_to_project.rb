class AddViewsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :views, :integer
  end
end
