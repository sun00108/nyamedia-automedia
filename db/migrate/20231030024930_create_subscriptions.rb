class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.text :filter_params
      t.integer :status
      t.timestamps
    end
  end
end
