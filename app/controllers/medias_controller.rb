class MediasController < ApplicationController

  # GET /api/v1/medias
  def list
    limit = params[:limit] || 20
    if limit.to_i == -1
      medias = Media.all
    else
      page = params[:page] || 1
      medias = Media.page(page).per(limit)
    end
    render json: { code: 0, message: '', data: medias }
  end

  # GET /api/v1/medias/filters
  def filters
    medias = Media.search(media_filter_params)
    render json: { code: 0, message: '', data: medias }
  end

  private

  def media_filter_params
    params.permit(:name, :season, :episode, :year, :quality, :source, :source_type, :video_codec, :audio_codec)
  end

end
