class AddEmbedCodeToProject < ActiveRecord::Migration
  def change
    add_column :projects, :embed_code, :text
  end
end
