class TorrentsController < ApplicationController

  # GET /api/v1/torrents
  def list
    torrents = Torrent.all
    render json: { code: 0, message: '', data: torrents }
  end

  # DEV
  # POST /api/v1/torrents/:id/scrape
  def scrape
    torrent = Torrent.find(params[:id])
    torrent.scrape
    render json: { code: 0, message: '', data: {}}
  end



end
