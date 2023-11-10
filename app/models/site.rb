class Site < ApplicationRecord
  has_many :rss_feeds, dependent: :destroy

  enum architecture: {
    nexusphp: 0,
    dmhy: 1
  }
end
