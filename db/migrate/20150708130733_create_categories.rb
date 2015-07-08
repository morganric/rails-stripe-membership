class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :user_id
      t.string :slug

      t.timestamps null: false
    end
  end
end
