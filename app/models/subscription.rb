class Subscription < ApplicationRecord

  before_create :set_default_status

  serialize :filter_params, Hash

  def self.update()
    subscriptions = Subscription.where(status: 1)
    subscriptions.each do |subscription|
      print("Checking subscription #{subscription.filter_params}")
      medias = Media.includes(:torrent).search(subscription.filter_params.symbolize_keys)
      medias.each do | media |
        if media.torrent.status == 'pending'
          media.torrent.download
        end
      end
    end
  end

  private

  def set_default_status
    self.status ||= 1
  end

end
