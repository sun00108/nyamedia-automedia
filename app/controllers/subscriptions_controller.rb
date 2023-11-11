class SubscriptionsController < ApplicationController

  # GET /api/v1/subscriptions
  def list
    subscriptions = Subscription.all
    render json: { code: 0, message: '', data: subscriptions }
  end

  # POST /api/v1/subscriptions/create
  def create
    filter_params = subscription_params[:filter_params].to_h.to_h # 你也别问 我也不懂
    subscription = Subscription.new(filter_params: filter_params)
    if subscription.save
      render json: { code: 0, message: '', data: {}}
    else
      render json: { code: 400, message: subscription.errors.full_messages.join(', '), data: {}}
    end
  end

  # POST /api/v1/subscriptions/:id/update
  def update
    subscription = Subscription.find(params[:id])
    if subscription.update(subscription_params)
      render json: { code: 0, message: '', data: {}}
    else
      render json: { code: 400, message: subscription.errors.full_messages.join(', '), data: {}}
    end
  end

  # POST /api/v1/subscriptions/:id/delete
  def delete
    subscription = Subscription.find(params[:id])
    subscription.destroy
    render json: { code: 0, message: '', data: {}}
  end

  private

  def subscription_params
    params.require(:subscription).permit(:status, filter_params: {})
  end

end
