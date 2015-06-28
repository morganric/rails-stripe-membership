class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :cover
      t.string :images
      t.string :image
      t.string :video
      t.integer :user_id
      t.string :slug

      t.timestamps null: false
    end
  end
end
