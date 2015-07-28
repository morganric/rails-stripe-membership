class AddFontToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :font, :string
  end
end
