class CreateMedia < ActiveRecord::Migration[6.1]
  def change
    create_table :media do |t|
      t.string :name
      t.integer :season
      t.integer :episode
      t.integer :year
      t.string :quality
      t.string :source
      t.string :source_type
      t.string :video_codec
      t.string :audio_codec
      t.references :torrent, null: false, foreign_key: true
      t.timestamps
    end
  end
end
