class SitesController < ApplicationController

  # POST /api/v1/sites/create
  def create
    site = Site.new(site_params)
    if site.save
      render json: { code: 0, message: '', data: {}}
    else
      render json: { code: 400, message: site.errors.full_messages.join(', '), data: {}}
    end
  end

  private

  def site_params
    params.require(:site).permit(:name, :architecture)
  end

end
