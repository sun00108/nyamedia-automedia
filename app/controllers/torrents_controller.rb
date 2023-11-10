class TorrentsController < ApplicationController

  # DEV
  # POST /api/v1/torrents/:id/scrape
  def scrape
    torrent = Torrent.find(params[:id])
    torrent.scrape
    render json: { code: 0, message: '', data: {}}
  end



end
