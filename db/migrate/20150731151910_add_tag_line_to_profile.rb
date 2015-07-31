class AddTagLineToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :tag_line, :string
    add_column :profiles, :contact_email, :string
  end
end
