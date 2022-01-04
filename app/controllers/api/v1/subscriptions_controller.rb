class Api::V1::SubscriptionsController < ApplicationController
  before_action :require_valid_customer, except: :update
  before_action :require_valid_tea, except: :update

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: { error: 'bad_request' }, status: :bad_request
    end
  end

  def update
    subscription = Subscription.find_by(id: params[:id])
    if subscription
      subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(subscription), status: 200
    else
      render json: { error: 'bad_request' }, status: :bad_request
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
    params.permit(:customer_id, :tea_id, :title, :price, :frequency, :status)
  end
end
