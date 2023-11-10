require 'feedjira'
require 'open-uri'

class RssFeed < ApplicationRecord
  belongs_to :site
  has_many :torrents, dependent: :destroy

  def update_all
    feed = Feedjira.parse(URI.parse(url).open.read)
    feed.entries.each do |entry|
      torrents.find_or_create_by(guid: entry.entry_id) do | torrent |
        torrent.title = entry.title
        torrent.url = entry.url
        torrent.magnet = entry.image
      end
    end
  end
end
