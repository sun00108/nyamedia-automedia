class CreateRssFeeds < ActiveRecord::Migration[6.1]
  def change
    create_table :rss_feeds do |t|
      t.string :url, null: false
      t.references :site, null: false, foreign_key: true

      t.timestamps
    end
  end
end
