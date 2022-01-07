class Api::V1::SubscriptionsController < ApplicationController
  before_action :require_valid_customer
  before_action :require_valid_tea, only: :create
  before_action :require_valid_status

  def index
    subscriptions = current_customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions), status: :ok
  end

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { errors: subscription.errors.full_messages }, status: :bad_request
    end
  end

  def update
    subscription = Subscription.find_by(id: params[:id], customer_id: params[:customer_id])
    if subscription
      subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(subscription), status: :ok
    else
      render json: { errors: 'Subscription not found' }, status: :bad_request
    end
  end

  private

  def require_valid_customer
    render json: { errors: 'Customer not found' }, status: :bad_request unless current_customer
  end

  def current_customer
    Customer.find_by(id: params[:customer_id])
  end

  def require_valid_tea
    render json: { errors: 'Tea not found' }, status: :bad_request unless current_tea
  end

  def current_tea
    Tea.find_by(id: params[:tea_id])
  end

  def subscription_params
    params.permit(:customer_id, :tea_id, :title, :price, :frequency, :status)
  end

  def require_valid_status
    if params[:status] && params[:status] != "active" && params[:status] != "cancelled"
      render json: { errors: 'Status not valid' }, status: :bad_request
    end
  end
end
