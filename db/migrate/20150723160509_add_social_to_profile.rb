class AddSocialToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :tumblr, :string
    add_column :profiles, :instagram, :string
  end
end
