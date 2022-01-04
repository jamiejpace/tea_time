class Api::V1::SubscriptionsController < ApplicationController
  before_action :require_valid_customer
  before_action :require_valid_tea

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: { error: 'no subscription found' }, status: 404
    end
  end

  private

  def require_valid_customer
    render json: { error: 'bad request' }, status: :bad_request unless valid_customer
  end

  def valid_customer
    Customer.find_by(id: params[:customer_id])
  end

  def require_valid_tea
    render json: { error: "bad request" }, status: :bad_request unless valid_tea
  end

  def valid_tea
    Tea.find_by(id: params[:tea_id])
  end

  def subscription_params
    params.permit(:customer_id, :tea_id, :title, :price, :frequency)
  end
end
