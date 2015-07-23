class AddDateToItem < ActiveRecord::Migration
  def change
    add_column :items, :start, :date
    add_column :items, :end, :date
  end
end
