class AddTagsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :tag_list, :string
  end
end
