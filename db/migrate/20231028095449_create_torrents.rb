class CreateTorrents < ActiveRecord::Migration[6.1]
  def change
    create_table :torrents do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :magnet, null: false
      t.string :guid, null: false
      t.integer :status, null: false, default: 0
      t.references :rss_feed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
