class Api::V1::TeasController < ApplicationController
  def create
    tea = Tea.new(tea_params)
    if tea.save
      render json: TeaSerializer.new(tea), status: 201
    else
      render json: { error: 'bad request' }, status: :bad_request
    end
  end

  private

  def tea_params
    params.permit(:title, :description, :temperature, :brew_time)
  end
end
