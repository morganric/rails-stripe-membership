class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :second_name
      t.string :image
      t.text :bio
      t.string :twitter
      t.string :cover
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
