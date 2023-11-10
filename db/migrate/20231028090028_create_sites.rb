class CreateSites < ActiveRecord::Migration[6.1]
  def change
    create_table :sites do |t|
      t.string :name, null: false
      t.integer :architecture, null: false

      t.timestamps
    end
  end
end
