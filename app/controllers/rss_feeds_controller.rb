class RssFeedsController < ApplicationController

  # POST /api/v1/sites/:site_id/rsscreate
  def create
    site = Site.find(params[:site_id])
    rss_feed = site.rss_feeds.new(rss_feed_params)
    if rss_feed.save
      render json: { code: 0, message: '', data: {}}
    else
      render json: { code: 400, message: rss_feed.errors.full_messages.join(', '), data: {}}
    end
  end

  # POST /api/v1/rss/update
  def update_all
    RssFeed.all.each do |rss_feed|
      if rss_feed.id == 2
        rss_feed.update_all
      end
    end
    render json: { code: 0, message: '', data: {}}
  end

  private

  def rss_feed_params
    params.require(:rss_feed).permit(:url)
  end

end
