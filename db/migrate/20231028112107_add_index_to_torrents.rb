class AddIndexToTorrents < ActiveRecord::Migration[6.1]
  def change
    add_index :torrents, :guid, unique: true
  end
end
